This example perfomrs the Markov data-based control (MDC) of a simple pendulum.

pendulum_gen_sym.m generates the simple_pendulum.mat file which includes the Markov parameters, reference trajectories and other necessary parameters for result visualization for the simple pendulum MDC control example.

pendulum_animation.m generates the gif animation of the control process for the simple pendulum.

pendulum_simulation.m generates the dymanic simulation for simple pendulum.

simple_pendulum.m includes the dynamics of a simple pendulum, and generates corresponding responses according to given inputs and initial conditions.

main_pendulum_ref_tracking.m exucutes the reference tracking control for the simple pendulum. Specific steps include the following:
1. Generate the reference tracking trajectory and Markov parameters
2. Initialize output and input weight matrices, and simulation
3. Results of the control
4. Generate gif to visually verify control efforts