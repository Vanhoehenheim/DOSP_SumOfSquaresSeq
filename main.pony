use "collections"

actor Worker
  let boss: Boss
  let id: U64
  let k: USize

  new create(boss': Boss, id': U64, k': USize) =>
    boss = boss'
    id = id'
    k = k'

  be check_perfect_square_seq(start: U64, stop: U64) =>
    for n in Range(start.usize(), (stop + 1).usize()) do
      if can_start_perfect_square_sequence(n.u64()) then
        boss.receive_result(n.u64())
      end
    end
    boss.worker_done()

  fun can_start_perfect_square_sequence(start: U64): Bool =>
    var sum: U64 = 0
    for i in Range(0, k) do
      let term = start + i.u64()
      sum = sum + (term * term)
    end
    is_perfect_square(sum)

  fun is_perfect_square(n: U64): Bool =>
    let sqrt = n.f64().sqrt().u64()
    (sqrt * sqrt) == n

actor Boss
  let env: Env
  let worker_count: USize
  var workers_done: USize = 0

  new create(env': Env, worker_count': USize) =>
    env = env'
    worker_count = worker_count'

  be receive_result(n: U64) =>
    env.out.print(n.string())

  be worker_done() =>
    workers_done = workers_done + 1
    if workers_done == worker_count then
      env.out.flush()
    end

  be assign_work(start: U64, stop: U64, k: USize) =>
    let range_size = ((stop - start) / worker_count.u64())
    let actual_worker_count = if stop < worker_count.u64() then
        (stop - 1).usize().max(1)
      else
        worker_count
      end
    
    for i in Range(0, actual_worker_count) do
      let worker_start = start + (i.u64() * range_size)
      let worker_stop = 
        if i == (actual_worker_count - 1) then
          stop
        else
          worker_start + (range_size - 1)
        end
      
      let worker = Worker(this, i.u64(), k)
      worker.check_perfect_square_seq(worker_start, worker_stop)
    end

actor Main
  new create(env: Env) =>
    try
      let args = env.args
      
      if args.size() < 3 then
        env.out.print("Usage: lukas <N> <k>")
        error
      end

      let worker_count : USize = 4
      let n = args(1)?.u64()?
      let k = args(2)?.usize()?

      let boss = Boss(env, worker_count)
      boss.assign_work(1, n, k)
    else
      env.out.print("Error parsing arguments. Usage: lukas <N> <k>")
    end