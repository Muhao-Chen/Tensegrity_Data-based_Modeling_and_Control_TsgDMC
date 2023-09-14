This example perfomrs the system identification of a clamped free beam using QMC.

clamped_free_beam.m returns a linearized continuous state space realization for a clamed free beam.

main_beam_sysID.m exucutes the system identification for the clamped free beam using QMC. Specific steps include the following:
Step 1: Generate Markov and Covariance parameters
Step 2: Construct data matrix
Step 3: Check existence condition and find QMC solution
Step 4: Perform simulation
Step 5: Plot the results