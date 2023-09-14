This example perfomrs the system identification of a simple pendulum.

pendulum_gen_sym.m generates the simple_pendulum.mat file which includes the Markov parameters for the simple pendulum system identification example.

simple_pendulum.m includes the dynamics of a simple pendulum, and generates corresponding responses according to given inputs and initial conditions.

main_pendulum_sysID.m exucutes the system identification for the simple pendulum using ERA. Specific steps include the following:

1. Generate Markov parameters
2. Construct Hankel matrices
3. Determine model complexity
4. Simulation
5. Result visualization