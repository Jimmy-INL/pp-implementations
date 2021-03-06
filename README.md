# A collection of numerical tests using PorePy

This GitHub repository is intended to serve as a (almost personal) collection of numerical tests for problems in saturated-unsaturated deformable-fractured porous media. All the implementations are part of the PhD project: Fracturing of porous media in the presence of multiphase flow at the University of Bergen, Norway. 

The test cases are presented in Jupyter Notebooks and are intended to be self-explanatories (at least to a certain degree).

To be able to run the notebooks, you should have a Python 3.6 distribution installed in your machine and the latest PorePy realease (see www.github.com/pmgbergen/porepy). It will be wise to check at least a few tutorials from PorePy, specially the MPFA, MPSA, Biot and Automatic Differentiation tutorials, which are used extensively.

## Table of contents :)

### Unsaturated flow

1. richards.ipynb: Pseudo-one dimensional water infiltration in a homogeneous soil column.
2. convergence_richards_1.ipynb: Convergence analysis #1: simple non-linear relationship for theta(psi), C^{theta}(psi) and krw(psi).
3. convergence_richads_2.ipynb: Convergence analysis #2: inclusion of van Genuchtem-Mualem curves instead of simplistic non-linear relationship.

### Linear poroelasticity

1. terzaghi.ipynb: Pseudo-one dimensional Terzaghi's consoladation problem.
2. mandel.ipynb: Mandel's two-dimensional consolidation problem
3. biot_convergence: Convergence analysis on an unit square using a manufactured solution.

### Unsaturated linear poroelasticity

1. unsat_poro_conv_test_1.ipynb: Convergence analysis #1: simple non-linear relationship for S(p), C^S(p) and k_r^w(p).
2. unsat_poro_conv_test_2.ipynb: Convergence analysis #2: inclusion of (modified) van Genuchten-Mualem curves and gravity effects instead of simplistic non-linear relationship.
