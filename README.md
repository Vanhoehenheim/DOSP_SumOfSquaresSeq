# DOSP_SumOfSquaresSeq
<h1>GROUP SUBMISSION:</h1>

Name: Abhay Shreekant Shastry
UFID: 19482010

Name: Prajay Prashanth Panangadan
UFID: 32637035


1) Maximum Size of work unit:

If the total size of the input is "n", we determined the size of work unit for "a" actors to be n/a(n divided by a). Each worker gets a range such that it can work independently wihtout communicating with other actors. There is a simple flow from the boss to the worker and back which results in optimum performance

For determining the value of "a" we ran a few tests with different values of a to detemine the value we'd use. Upon analysis, we arrived at a = 4. Below are a few performance values for different a values for 2 sets of inputs:


For 1000000 2
 a = 12; User CPU Time = 0.08 ; System Cpu Time: 0.00; Total Time : 0.217
 a = 4;  User CPU Time = 0.07 ; System Cpu Time: 0.00; Total Time : 0.222
 a = 2;  User CPU Time = 0.04 ; System Cpu Time: 0.00; Total Time : 0.204
 a = 20; User CPU Time = 0.07 ; System Cpu Time: 0.00; Total Time : 0.192


For 1000000 4
 a = 12; User CPU Time = 0.07 ; System CPU Time: 0.00; Total Time : 0.217
 a = 4;  User CPU Time = 0.05 ; System CPU Time: 0.00; Total Time : 0.194
 a = 2;  User CPU Time = 0.06 ; System CPU Time: 0.00; Total Time : 0.193
 a = 20; User CPU Time = 0.03 ; System CPU Time: 0.00; Total Time : 0.010


2) Result of running program for lukas 1000000 4:

Result: No output result
There is no sequence of length 4 where the sum of xi^2 equals a perfect square for the range 1000000

3) The running time for the above as reported by time for the above:

User CPU Time : 0.10 seconds
System CPU Time : 0.00 seconds
Total time: 0.016 seconds

(User CPU Time + System CPU Time) / Total Time : 6.25


4) The Largest Value we managed to solve: 

By Keeping a = 4,
The largest value we could compute was for n: 4000000000000 and k: 24
Time Metrics for the above input:
User CPU Time: 12853.38 seconds (Approximately 3.5 Hours)
System CPU Time: 63.26 seconds
Total Time: 54 minutes 49.43 seconds