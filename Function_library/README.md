This file contains all necessary functions for the data-based modeling and control (DMC) analysis of tensegrity structures. 

tsgDMC_con2dis.m discretizes the continuous state space realization {A,B,C,D} into the discretized state space realization {Ad,Bd,Cd,Cd} using the specified method with the specified sample time.

tsgDMC_control.m computes the Markov data-based optimal input control sequence (control increment sequence for reference tracking applications) for the interval [k,N], using the information of reference trajectory of the interval [k,N] (r) and Markov data-based output estimate for the interval [k,N] (y_bar).

tsgDMC_dim_transform.m transforms the parameter sequence from 3D arrays to 2D arrays.

tsgDMC_Dq.m computes the data matrix Dq for the q-Markov Covariance equivalent realization (QMC).

tsgDMC_era.m computes a state space realization of order n using the Eigensystem Realization Algorithm (ERA), where Phi1 and Phi2 represent the two consecutive Hankel matrices, and n represents the desired size of the state space realization.

tsgDMC_estimate.m computes the Markov data-based output estimate for the interval [k,N].

tsgDMC_existence.m checks the existence condition of a QMC solution for the given data matrix Dq and a specified threshold sigma.

tsgDMC_gain.m computes the Markov data-based optimal controller gain at step k, which minimizes a cost function of accumulating output errors and inputs, with weight matrices Q and R, respectively, over the interval [k,N].

tsgDMC_genMarkov.m generates the first N Markov parameter sequence of the state space realization {A,B,C,D}.

tsgDMC_genCov.m generates the first N Covariance parameter sequence of the state space realization {A,B,C,D}.

tsgDMC_Hankel.m computes two consecutive Hankel matrices for ERA.

tsgDMC_Hq.m computes the Toeplitz matrix Hq for QMC.

tsgDMC_markov_transform.m computes the augmented input Markov parameters and augmented input disturbance Markov parameters from input Markov parameters and input disturbance Markov parameters. The augmented Markov parameters are used for reference tracking applications.

tsgDMC_pdm.m computes the perceived size of the state space realization n from the singular value decomposition of the data matrix using the power density method.

tsgDMC_plot_power.m visualizes the singular values of a data matrix.

tsgDMC_qmc.m computes a state space realization of order n that exactly matches q Markov and Covariance parameters using QMC.

tsgDMC_Rq.m computes the Toeplitz matrix Rq for QMC.