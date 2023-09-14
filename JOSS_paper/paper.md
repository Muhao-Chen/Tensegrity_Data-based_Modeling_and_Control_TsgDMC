---
title: 'TsgDMC: A Matlab package for data-based modeling and control of Tensegrity structures'
tags:
  - Tensegrity systems
  - Markov parameters
  - Databased modeling
  - Databased control
authors:
  - name: Yuling Shen
    orcid: 0000-0003-1955-1323
    affiliation: 1
  - name: Muhao Chen^[corresponding author]
    orcid: 0000-0003-1812-6835
    affiliation: 2
  - name: Robert E. Skelton
    orcid: 0000-0001-6503-9115
    affiliation: 3
affiliations:
 - name: School of Future Science and Engineering, Soochow University, Suzhou, Jiangsu, Chnia
   index: 1
 - name: Department of Mechanical and Aerospace Engineering, University of Kentucky, Lexington, KY, USA
   index: 2
 - name: Department of Aerospace Engineering, Texas A&M University, College Station, TX, USA
   index: 3
date: 1 September 2023
bibliography: paper.bib
---

# Summary

'TsgDMC,' recommended to be pronounced as Tenseg DMC, is a MATLAB software package designed for data-based modeling and control of tensegrity structures. This tool can also be extended to other systems where only input and output signals are available. The software offers two data-based modeling methods: the Eigensystem Realization Algorithm (ERA) and the q-Markov Covariance Equivalent Realization (QMC). Additionally, it provides a data-based control technique to implement a Linear Quadratic Gaussian (LQG) control law for both regulation and reference tracking control.

Detailed functionalities of the software include:

Data-based system identification:

  1. ERA: Identifies a state-space realization of order n, aiming to minimize error discrepancies between two consecutive Hankel matrices formed from Markov parameters.
  2. QMC: Identifies a state-space realization of order n, ensuring an exact match with the first q Markov and Covariance parameters of a system.

Data-based system control:

  1. Regulation: Implements an optimal LQG control law, minimizing the cumulative outputs and inputs using Markov parameters.
  2. Reference Tracking: Achieves an optimal LQG control law that reduces the accumulation of tracking discrepancies and input variations, utilizing Markov parameters


# Statement of need

Tensegrity structures, consisting of strings and bars, showcase each component subjected to uni-directional forces: strings experience tension, while bars face compression. These structures are noted for their lightweight [@chen2023minimal], multi-functional capabilities [@chen2020design], motion flexibility [@lu20236n], tunable structural parameters [@micheletti2022seventy], adaptability to different environments [@sabelhaus2015system], and deployability [@xue2023new]. With applications in aerospace, bioengineering, robotics, and architecture, tensegrity offers promising solutions to diverse engineering and scientific challenges ahead.

While tensegrity is increasingly popular, it presents notable modeling and control challenges. Some studies have suggested analytical modeling techniques. For instance, Skelton refined the analytical models for class-1 tensegrity dynamics [@skelton2005dynamics]. Kan et al. incorporated clustered cables into these dynamics [@kan2021comprehensive], while Ma et al. furthered this concept, deriving both nonlinear and linear tensegrity dynamics using the finite element method [@ma2022dynamics]. Based on these analytical models, various control methods for tensegrity systems have been devised. For instance, Sabelhaus et al. developed a control method for tensegrity soft robots using inverse kinematics [@sabelhaus2020model], while Chen et al. introduced a nonlinear shape control law suitable for tensegrity structures [@chen2020design]. Ma et al. contrived an optimal control law for managing clustered tensegrity structures [@ma2022dynamics]. Tang et al. proposed a self-vibration-control mechanism in tensegrity for specialized applications, ideal for large-scale space constructions demanding precision and shape integrity [@tang2022self]. Furthermore, Yang and Sultan presented a linear parameter-varying (LPV) controller targeting tensegrity-membrane systems [@yang2017lpv]. However, while analytical models elucidate the intrinsic properties of tensegrity structures and support precise model-based control, they have inherent limitations. Over-generalizations in mathematical modeling might only offer an incomplete system representation. Issues like material variability, joint friction, irregular forms, and manufacturing flaws may not be adequately modeled. In addition, real-world systems evolve due to wear and tear, fatigue, erosion, etc. Addressing these complications demands data-based modeling and control approaches.

The 'TsgDMC' software is a comprehensive tool for data-based modeling and control of tensegrity systems and can also cater to other black box dynamical systems. This toolbox, already used in multiple scientific publications [@shen2023markov,@shen2023q], integrates two system identification methods, ERA [@juang1985eigensystem,@majji2010time] and QMC [@liu1993new,@shen2023q]. While ERA specializes in flexible structure modal identification, QMC, primarily for model reduction, guarantees an exact match with the system's first q Markov and Covariance parameters. 'TsgDMC' also offers a direct control method, eliminating the modeling step, wherein a control law aiming to minimize a linear quadratic cost function—accumulating outputs and inputs for regulation and tracking errors and input increments for reference tracking—is based on input/output data [@shi2000markov,@shen2023markov]. However, users can employ their preferred model-based control techniques once data-based models are available.

The procedure of the data-based modeling and control follows the sequence below. First, the system's Markov and Covariance parameters are assessed using I/O data, employing techniques such as impulse tests, white noise experiments [@liu1993new], and input-output method [@juang1993identification]. When modeling with ERA, Markov parameters facilitate the construction of two sequential Hankel matrices. Subsequently, a reduced-order ERA solution is derived from the Hankel matrices' decomposition. In contrast, QMC-based modeling utilizes the first q Markov and Covariance parameters to establish a data matrix. Before computing a QMC solution from the matrix's decomposition, the existence condition of a solution is confirmed by ensuring the matrix is positive semi-definite. For data-based control, the Markov parameters apply an optimal control law that minimizes the quadratic sum of outputs and inputs within a regulation control horizon. For reference tracking control, these parameters are augmented and then employed to optimize the control law, minimizing the quadratic sum of tracking errors and input increments across a specified horizon.

In summary, 'TsgDMC' offers a robust data-driven toolbox tailored for the modeling and control needs of tensegrity systems.

# References

