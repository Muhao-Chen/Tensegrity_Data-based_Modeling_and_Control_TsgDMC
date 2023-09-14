This example perfomrs the system identification of a tensegrity morphing airfoil. 

airfoil_gen_sym.m generates the airfoil.mat file which includes the Markov parameters for the tensegrity airfoil system identification example.

discrete_airfoil.m includes the state space model of the discrete airfoil model, and generates corresponding responses according to given input signals and initial conditions.

main_tsg_airfoil_sysID.m exucutes the system identification for the tensegrity airfoil. Specific steps include the following:

1. Generate Markov parameters
2. Construct Hankel matrices
3. Determine model complexity
4. Simulation
5. Result visualization