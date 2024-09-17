# Sum Of Square Sequences

## COP5615 - Distributed Operating Systems Principles - Group Project 1

**Name**: Abhay Shreekant Shastry  
**UFID**: 19482010  

**Name**: Prajay Prashanth Panangadan  
**UFID**: 32637035  

---

### 1. Maximum Size of Work Unit

For a total input size of `n`, the size of each work unit for `a` actors was determined to be `n/a` (n divided by a). Each worker is assigned a range that allows independent processing, without the need for inter-worker communication. The communication flow is simple: from the master to the worker and back, achieving optimal performance.

To determine the optimal value of `a`, we ran tests with various values. After analysis, we found that `a = 4` provides good performance. Below are the performance results for different values of `a` on two input sets:

**For input size 1,000,000 with k = 2:**

| `a` | User CPU Time | System CPU Time | Total Time |
|-----|---------------|-----------------|------------|
| 12  | 0.08          | 0.00            | 0.217      |
| 4   | 0.07          | 0.00            | 0.222      |
| 2   | 0.04          | 0.00            | 0.204      |
| 20  | 0.07          | 0.00            | 0.192      |

**For input size 1,000,000 with k = 4:**

| `a` | User CPU Time | System CPU Time | Total Time |
|-----|---------------|-----------------|------------|
| 12  | 0.07          | 0.00            | 0.217      |
| 4   | 0.05          | 0.00            | 0.194      |
| 2   | 0.06          | 0.00            | 0.193      |
| 20  | 0.03          | 0.00            | 0.010      |

---

### 2. Result of Running the Program for `lukas 1000000 4`

**Result**: No sequence of length 4 exists such that the sum of squares of consecutive numbers equals a perfect square in the range of 1,000,000.

---

### 3. Running Time for the Above

- **User CPU Time**: 0.10 seconds  
- **System CPU Time**: 0.00 seconds  
- **Total Time**: 0.016 seconds  
- **Efficiency**: (User CPU Time + System CPU Time) / Total Time = 6.25  

---

### 4. Largest Value Computed

Using `a = 4`, the largest value computed was for `n = 4,000,000,000,000` and `k = 24`.

**Time Metrics for the above input**:
- **User CPU Time**: 12,853.38 seconds (~3.5 hours)
- **System CPU Time**: 63.26 seconds  
- **Total Time**: 54 minutes, 49.43 seconds  

### 5. How to run this program

To run the program, follow the steps below:

**Compile the Program**

Ensure you have the Pony programming language installed. Compile the main.pony file using the following command:

```
pony .
```
This command will generate an executable file in the current directory

**Execute the Program**

Once compiled, you can run the executable with two command-line arguments: the input size and sequence size. The format is as follows:

```
./SumOfSquares <input_size> <sequence_size>
```
