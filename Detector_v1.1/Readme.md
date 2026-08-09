# 🔄 Feedback-Driven Adaptive Learning 
- Introduces feedback-driven adaptation on top of [Detector_v1.0](../Detector_v1.0), a popcount based judgement system with manually alterable decision boundary.
- Automatic threshold adjustment based on error signal which would allow the detector to gradually converge towards an appropriate threshold to correct the recognition output.
- It formed basis of a cybernetic self-learning adaptive system that would be capable of altering its decision boundaries.

## 🧠 Adaptive Learning Algorithms 
- [Max-Initialized Decremental Search (MIDS)](Max-Initialized%20Decremental%20Search)
- [State Aware Threshold Update (SATU)](State%20Aware%20Threshold%20Update)

| Property | MIDS | SATU |
|---|---|---|
| Correction Speed | O(N) | O(1) |
| State Awareness | None | Current & desired output |
| Correction Strategy | Iterative threshold traversal | Direct threshold computation |
| Direction | Starts from maximum threshold and decrements | Computes `T = M−1` or `T = M` directly |
| Threshold Storage | Requires threshold memory | No threshold memory required |
| Traversal Logic | Required | Not required |
| Synchronization | Multiple synchronization requirements | Single synchronizer |
| Control Hardware | Large control loop coordinating traversal | Simpler control path |
| Initialization | Requires programmed threshold memory and correct setup sequence | Start the system and provide the required inputs |
| Hardware Complexity | Higher | Lower |
| External Setup Complexity | Higher | Very low |
| Guaranteed Convergence | Yes, for M ∈ {1,...,15} | Yes, for M ∈ {1,...,15} |
| Algorithmic Principle | Search for the boundary | Compute the boundary |

## 🎯 Convergence Proofs
- [MIDS Convergence Proof](https://github.com/KARAN-D05/Gate-Level-Perceptron/tree/main/Detector_v1.1/Max-Initialized%20Decremental%20Search#-convergence-proof)
- [SATU Convergence Proof](https://github.com/KARAN-D05/Gate-Level-Perceptron/tree/main/Detector_v1.1/State%20Aware%20Threshold%20Update#-convergence-proof)

## ⏱️ Correction Speed Complexity Comparison

<p align="center">
  <img src="images/Speed_Complexity.png" alt="Speed-Complexity" width="600">
</p>
