use "collections"
use "time"

actor Worker
  let env: Env
  let boss: Boss
  let id: U64
  let k: USize

  new create(boss': Boss, id': U64, k': USize, env' : Env) =>
    boss = boss'
    id = id'
    k = k'
    env = env'

  be check_perfect_square_seq(start: U64, stop: U64) =>
    let result: Array[U64] iso = recover iso Array[U64] end
    for n in Range(start.usize(), (stop + 1).usize()) do
      if can_start_perfect_square_sequence(n.u64()) then
        result.push(n.u64())
      end
    end
    boss.receive_result(id, consume result)

  fun can_start_perfect_square_sequence(start: U64): Bool =>
    var sum: U64 = 0
    for i in Range(0, k) do
      let term = start + i.u64()
      sum = sum + (term * term)
    end
    if is_perfect_square(sum) then
    //   env.out.print("Found perfect square sequence starting at " + start.string() + " with sum " + sum.string())
      true
    else
      false
    end

  fun is_perfect_square(n: U64): Bool =>
    let sqrt = n.f64().sqrt().u64()
    (sqrt * sqrt) == n

actor Boss
  let env: Env
  let worker_count: USize
  var responses_received: USize = 0
  let results: Array[Array[U64] val] = Array[Array[U64] val]
  let k: USize

  new create(env': Env, worker_count': USize, k': USize) =>
    env = env'
    worker_count = worker_count'
    k = k'

  be receive_result(id: U64, worker_result: Array[U64] iso) =>
    results.push(consume worker_result)
    responses_received = responses_received + 1

    // env.out.print("Received result from Worker " + id.string() + " (" + responses_received.string() + "/" + worker_count.string() + ")")
    // try
    //   env.out.print("Numbers found: " + ",".join(results(responses_received - 1)?.values()))
    // else
    //   env.out.print("Error: Unable to access the latest result.")
    // end

    if responses_received == worker_count then
      // Combine and print all results
      let all_numbers = Array[U64]
      for worker_array in results.values() do
        for num in worker_array.values() do
          all_numbers.push(num)
        end
      end
      env.out.print("All numbers found: " + ",".join(all_numbers.values()))
    end

  be assign_work(start: U64, stop: U64) =>
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
      
      let worker = Worker(this, i.u64(), k, env)
      worker.check_perfect_square_seq(worker_start, worker_stop)
      env.out.print("Assigned work to Worker " + i.string() + ": " + worker_start.string() + " to " + worker_stop.string())
    end

actor Main
  new create(env: Env) =>
    try
      let args = env.args
      
      if args.size() < 3 then
        env.out.print("Usage: program <range> <k>")
        error
      end

      let worker_count : USize = 4
      let range = args(1)?.u64()?
      let k = args(2)?.usize()?

      env.out.print("Starting with " + worker_count.string() + " workers, K=" + k.string() + 
                    " 1 to " + range.string())

      let boss = Boss(env, worker_count, k)
      boss.assign_work(1, range)
    else
      env.out.print("Error parsing arguments. Usage: program <range> <k>")
    end