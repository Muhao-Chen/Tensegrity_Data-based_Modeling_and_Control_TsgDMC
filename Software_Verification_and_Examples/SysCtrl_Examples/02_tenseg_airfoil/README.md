This example perfomrs the Markov data-based control of a tensegrity airfoil for regulation and reference tracking applications.

airfoil_gen_sym.m generates the airfoil.mat file which includes the Markov parameters, reference trajectories and other necessary parameters for result visualization for the tensegrity airfoil MDC control example.

airfoil_animation.m generates the gif animation of the control process for the tensegrity airfoil.

dyn_airfoil.m computes the dynamics of a tensegrity airfoil.
Reference: Ma, S., Chen, M., & Skelton, R. E. (2022). TsgFEM: Tensegrity Finite Element Method. Journal of Open Source Software, 7(75), 3390.

discrete_airfoil.m includes the state space model of the discrete airfoil model, and generates corresponding responses according to given input signals and initial conditions.

main_airfoil_ref_tracking.m exucutes the Markov data-based reference tracking control for the tensegrity airfoil. Steps of Markov data-based reference tracking control include the following:
1. Import reference tracking trajectory and Markov parameters
2. Initialize output and input weight matrices and noise variances
3. Guess initial output estimate
4. Calculate optimal controller gain, update output estimate, and compute input sequence
5. Visualize Control Process

main_airfoil_regulation.m exucutes the Markov data-based regulation control for the tensegrity airfoil. Steps of Markov data-based regulation control includes the following:
1. Import reference tracking trajectory and Markov parameters
2. Initialize output and input weight matrices and noise variances
3. Guess initial output estimate
4. Calculate optimal controller gain, update output estimate, and compute input sequence
5. Visualize Control Process