#  📉 Max-Initialized Decremental Search (MIDS)

- MIDS is a blind, state-unaware threshold correction algorithm that 
guarantees convergence through exhaustive decremental search.
- On receiving an error signal, MIDS does not evaluate the current 
output state or reason about the desired state. Instead it follows 
a fixed procedure: reset the threshold to its maximum value (15) 
and begin decrementing by 1 each clock cycle until the output 
reverses and correction is achieved.
- The core insight is that starting from maximum coverage guarantees 
the search will encounter the correction boundary regardless of 
where it lies. No decision logic, no state comparison, just a 
bounded search from ceiling to correction.

- **Complexity:** O(N) - worst case 15 clock cycles if correction 
occurs at threshold 0.

- **Hardware:** Minimal - a decrementer and a cell pointer. 
No incrementer, no thinking module, no state awareness required.

- **Tradeoff:** Simplicity and minimal area at the cost of 
correction speed.

<p align="center">
  <img src="Videos/Cybernetic%20Feedback%20Driven%20Adaptive%20Learning-16Hz.gif" alt="Adaptive Learning Demonstration" width="1500">
</p>

<p align="center">
  <sub></b> 🤖 Cybernetic self-learning adaptive system implementing MIDS algorithm - Operating at 16 Hz Clock and autonomously altering its decision boundary while detecting and supressing the timing hazard
</p>

```
                                                    🐾 Execution Trace

      1) Initial State θ = 12, M = 8, M < θ, Recogntion -> 0
      2) Error_In pressed to signal error to the system
      3) System takes over control and starts inmplementing MIDS, initialize to 15 and decrements until output correction
      4) At θ = 7, M > θ, output flips, Recognition becomes 1, system converges and is stable at M > θ = 7, success flag goes
         high indicating successfull convergence
      5) As soon as convergence occurs, the system is rearmed for next correction sequence automatically 
      6) The correction success flag is manually cleared before next correction so we can track correction have occurred and
         it works as a visual aid
      7) Now system is stable at M = 8, θ = 7, Recogntion -> 1.
      8) We again press Error_In for another adaptive cycle and system again starts MIDS and initialize to 15 making θ > M
         instantly acheiving non-recognition
      9) This instant correction demonstrated initialization bias of MIDS for correction of false-positives 
```

## 🎛️ Initialization Bias
- The system activation function R(M, θ) = 1 if M > θ, else 0 creates an inherent asymmetry that interacts with the algorithm's starting state.
  
- MIDS initializes θ = 15 which ensures M > θ is false for all valid M ≤ 15 , yielding a default output of 0 (Non-Recognition) for all M ∈ {0, ..., 15}. Consequently, any error requiring non-recognition output is corrected with zero latency - a strong bias towards caution resulting in instant correction for false positives while recognition requires traversal to θ = M - 1 with latency 15 - (M - 1). Preferable in systems where false positives must be corrected with zero latency.

- Conversely, if we initialize θ = 0 (LIDS, Least-initialized decremental search), it produces a default output of 1 (Recognition) for all M ∈ {1, ..., 15}, a strong bias towards eagerness and instant correction of false negatives. Preferable in systems where false negatives must be corrected with zero latency.

- Formally, the Bias manifests as a subset of inputs for whcih correction latency is O(1) rather than worst case O(N).

## 🎯 Convergence Proof
```
System Activation Function:
R(M, θ) = 1 if M > θ, else 0

Threshold Range: θ ∈ {0, ..., 15}

Decision Flipping Space(DFS):
For a given M, the Decision Flipping Space is defined as:

DFS⁺(M) = M - 1 = threshold value that flips output to recognition
DFS⁻(M) = M = threshold value that flips output to non-recognition

DFS existence for valid M
For all M ∈ {1, 2, ..., 15}:

DFS⁺(M) = M - 1 ∈ {0, 1, ..., 14} ⊆ {0, ..., 15} 
DFS⁻(M) = M ∈ {1, 2, ..., 15} ⊆ {0, ..., 15}

⇒ Valid decision-flipping spaces always exist inside the Threshold Range: θ ∈ {0, ..., 15}

MIDS operates as:
θₙ₊₁ = θₙ - 1
starting from θ = 15

This generates a strictly decreasing sequence:
15→14→⋯⋯→0

Since:
θ traverses all values in [15→0] and DFS⁺(M), DFS⁻(M) ⊆ {0, ..., 15}
MIDS is guaranteed to hit the required flipping threshold in finite steps

```

- Since a valid decision-flipping threshold always exists for all valid M, and MIDS monotonically traverses the entire threshold space, the algorithm is guaranteed to reach a flipping point in finite time. Therefore, MIDS always converges.
- Worst-case convergence occurs when the flipping threshold is at θ = 0, yielding O(N) complexity where N is the threshold range.

- `Edge cases excluded by design:`
  - M = 0: Non-recognition always. No meaningful flip desired.
  - M = 16: Recognition always. No meaningful flip desired.
  - In both cases, no decision boundary exists within the threshold space, hence no correction is possible or required.

<p align="center">
  <img src="Videos/No%20Corrective%20Decision%20Boundary.gif" alt="Adaptive Learning Demonstration" width="1500">
</p>

<p align="center">
  <sub></b> System Unable to converge due to non-existence of decision boundary for M=16
</p>
