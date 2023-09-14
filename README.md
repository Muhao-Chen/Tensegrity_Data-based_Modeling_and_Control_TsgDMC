# Tensegrity Data-based Modeling and Control (TsgDMC)

### **Welcome to **TsgDMC** software!**

#### General Information
Our research group focuses on integrating structure and control design for lightweight deployable structures. We utilize the principles of tensegrity to create structures that meet specific objectives. These objectives encompass the design of deployable structures, static and dynamic analysis of the structure, and controlling its performance based on specific requirements. The software aims to explore data-based modeling and control approaches for deployable tensegrity structures. The authors have made this software open-source to assist other researchers interested in this field.


---

**Cite this work as:**   
_Shen, Y., Chen, M., Skelton, R.E., 2023. TsgDMC: A Matlab package for data-based modeling and control of Tensegrity structures. Journal of Open Source Software, X(XX), XXXX._

---

The primary objective of this software is to simplify the process of modeling and control for Tensegrity structures using data-based approaches. It provides functionalities for system identification and optimal control of various tensegrity systems. The software's main contribution lies in these two key areas.


#### System Identification: 
1. Conduct system identification using the Eigensystem Realization Algorithm (ERA). ERA is a system identification and model reduction method that finds a state space realization from data, which minimizes the norm of errors between two consecutive Hankel matrices.
2. Conduct system identification or model reduction using q-Markov Covariance Equivalent Realization. QMC, initially designed for model reduction, finds a state space realization from data that exactly matches the first q Markov and Covariance parameters of a system.

#### Data-based Control: 
1. Regulatory Control. 
Regulatory Control requires N+1 Markov parameters, with N representing the extent of the control horizon. It aims to generate an optimal control law by minimizing a cost function that combines accumulated outputs and inputs. The primary objective of this control is to maintain system equilibrium while minimizing the energy used for control.
2. Reference Tracking. 
Reference Tracking involves N+1 Markov parameters along with a reference trajectory. This function calculates an optimal control law by minimizing a cost function that includes the accumulation of tracking errors between the reference trajectory and the system outputs and input increments. The main goal of Reference Tracking is to maneuver the system toward a predefined location using the most stable inputs available.


The name of this software _TsgDMC_ is suggested to be pronounced as _Tenseg DMC_. The software is versatile and capable of analyzing various structures beyond tensegrity structures. It can analyze structures such as pendulums, airfoils, and cable domes. Additionally, the software is suitable for analyzing tensile membranes (pure string-to-string networks) and truss structures (pure bar-to-bar networks). Its applicability extends to a wide range of structural configurations and black box systems.


Undergraduate linear algebra, material mechanics/continuum mechanics, linear control theory, and some basic knowledge of MATLAB are required to understand the codes well. This software is developed based on the following:
- 64-bit Windows
- MATLAB 

Note: Win7/Win10/Mac OS/Linux/Win XP/Win Vista, the software is compatible with a MATLAB version later than 2009a. However, if possible, we encourage users to run the software with the latest MATLAB release. (More information about MATLAB versions can be found here: https://en.wikipedia.org/wiki/MATLAB).


#### LICENSE

    /* This Source Code Form is subject to the terms of the Mozilla Public
     * License, v. 2.0. If a copy of the MPL was not distributed with this
     * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 
---

***<font size=4> Tensegrity Data-based Modeling and Control (TsgDMC) folder contains the following parts:</font>***

---

#### setup.m 
If one wants to start using the TsgDMC software, run the 'setup.m' first.
Open MATLAB and run the 'setup.m' file. It will:

- Add all library functions to the MATLAB path, 
- Add the Software Verification and Examples,
- Add User Guide,
- Add Videos folder,
- Add JOSS paper.

Note: setup.m must be run every time MATLAB opens before any other file.

#### JossPaper

This folder contains the journal paper corresponding to the software, including source file documents and references. The journal paper will provide the background introduction, a summary of our work, applications, references, etc. 

#### Function Library

This folder contains the following:

This folder organizes all the library functions for the analysis. By following instructions for System Identification and Data-based Control analysis from "User_Guide.pdf," one can perform the analysis.

#### Software Verification and Examples

This folder contains the following:

1. System Identification Examples

Here, we give examples to verify and demonstrate the system identification of this software.

2. Data-based Control Examples

Here, we give examples to verify and demonstrate the data-based control of this software.

#### User Guide

This folder contains "User_Guide.pdf." The file describes how to use the software and various applications and become a developer.

#### Videos
Some interesting tensegrity animation examples are shown in this folder.

---

### Help Desk:

We are open and willing to answer any question. Please state your problem clearly and use the following emails to contact: Muhao Chen: <muhaochen@uky.edu>, Yuling Shen: <ylshen07@suda.edu.cn>. Thank you!

<!-- ---- -->

<!-- ### Acknowledgment:

The authors want to thank [Dr. Kevin Mattheus Moerman](https://kevinmoerman.org/), [Dr. Patrick Diehl](https://www.diehlpk.de/), and [Mr. Rohit Goswami](https://rgoswami.me/) for their great help in improving the software. They are nice, patient, and professional researchers. Thank you, indeed! -->

----

### Join the TsgDMC Community and Contribute

#### How to contribute

Feedback and contributions are appreciated. Please use the same terminology so everybody can be on the same page.

1. Fork it
2. Submit a pull request OR send emails to the help desk.

We will reply to you ASAP.

#### Coding standards

* MATLAB (>= 2009a)
* Function input and output comments
* Use the same Nomenclature as follows

#### Nomenclature

##### System Identification
    H: Markov parameters
    R: Covariance parameters
    a: the number of Markov parameters in the column of the Hankel matrix
    b: the number of Markov parameters in the row of the Hankel matrix
    q: Number of Markov and Covariance parameters to exactly match 
    Phi1: first Hankel Matrix
    Phi2: second Hankel Matrix
    Hq: Toeplitz matrix Hq
    Rq: Toeplitz matrix Rq
    Uq: Input Covariance 
    Dq: data matrix Dq
    exi: existence condition of QMC solution
    sigma: Ratio of the preserved power density
    n: desired size of the state space realization
    A: state matrix of the state space realization
    B: input matrix of the state space realization
    C: output matrix of the state space realization
    D: feedthrough matrix of the state space realization
    Ac: continuous state matrix of the state space realization
    Bc: continuous input matrix of the state space realization
    Cc: continuous output matrix of the state space realization
    Dc: continuous feedthrough matrix of the state space realization
    sample time: Sampling time of the discretization
    method: the specified discretization method, ex., 'zoh','foh','impulse'
    Ad: discrete state matrix of the state space realization
    Bd: discrete input matrix of the state space realization
    Cd: discrete output matrix of the state space realization
    Dd: discrete feedthrough matrix of the state space realization

##### System Control
    H: input Markov parameters
    M: input disturbance Markov parameters
    H_hat: augmented input Markov parameters
    M_hat: augmented input disturbance Markov parameters
    k: current step
    N: horizon
    Q: output weight matrix
    R: input increment weight matrix
    K: optimal controller gain
    y_est_pre: previous Markov-databased output estimate
    y_pre: previous output
    u_pre: previous input
    H: input Markov parameters
    M: input disturbance Markov parameters
    W: input disturbance variance
    V: output sensor variance
    y_est: Markov-databased output estimate for the interval [k,N]
    r : reference trajectory for the desired horizon
    u: input control sequence (control increment sequence for reference tracking applications)
