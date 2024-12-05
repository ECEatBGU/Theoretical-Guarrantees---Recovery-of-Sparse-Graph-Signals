# Theoretical-Guarrantees---Recovery-of-Sparse-Graph-Signals

Code for the Paper: “Theoretical Guarantees for Sparse Graph Signal Recovery”

This repository provides the codebase used to study the behavior of graph Laplacian mutual coherence over Erdős–Rényi and sensor graphs. It evaluates the accuracy of the upper and lower bounds proposed in [1] for the graph Laplacian mutual coherence. Results demonstrate the relationship between mutual coherence, its bounds, and the graph’s minimal degree, showing that an increased minimal graph degree reduces mutual coherence, as theoretically established in [1]. The repository also explores how these findings affect the sparse recovery performance of Orthogonal Matching Pursuit (OMP) and Lasso (￼ relaxation).

Reference

[1] G. Morgenstern and T. Routtenberg, “Theoretical guarantees for sparse graph signal recovery,” accepted, IEEE Signal Process. Lett., 2024.

The repository is organized to facilitate simulation and visualization of the results. Two master scripts are provided for running simulations: one dedicated to studying the mutual coherence and the other focused on sparse recovery. Each master script is associated with a corresponding slave script, which performs the computations.

For visualizing the results, two additional master scripts are included, one for mutual coherence and the other for sparse recovery. Like the simulation scripts, these visualization scripts also rely on corresponding slave scripts for detailed plotting tasks.

The results of simulations are stored as matrix arrays in the “Results” folder. These arrays are then imported by the plotting scripts to generate figures, which are saved in the “Figures” folder. The repository is designed with an intuitive structure, and comments are included in most scripts to assist users in understanding and navigating the codebase.
