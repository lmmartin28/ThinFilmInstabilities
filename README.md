# ThinFilmInstabilities
Repository gathering code to simulate the time evolution of a film on an inclined substrate under the combined effect of Laplace Pressure and Van der Waals Interactions

The provided code is consistent with the framework outlined in the paper by Martin-Monier and Ledda, simulating the dewetting process of thin films under specific conditions. It models the evolution of film thickness over time through partial differential equations that account for intermolecular interactions and surface tension forces. Fourier-based methods are employed to calculate spatial derivatives, allowing for efficient processing of the film's surface profile. The time-dependent evolution of the film’s thickness is simulated using numerical integration with ODE solvers. Additionally, the code ensures mass conservation during the simulation, maintaining physical accuracy. The results are visualized in 3D, providing insights into the film's morphology during the dewetting process.
For More informations regarding the associated works, please refer to the following works:
	L. Martin-Monier, P. G. Ledda, P. L. Piveteau1, F. Gallaire, and F. Sorin, Prediction of Self-Assembled Dewetted Nanostructures for Photonics Applications via a Continuum-Mechanics Framework, Phys. Rev. Applied 16, 034025. https://journals.aps.org/prapplied/abstract/10.1103/PhysRevApplied.16.034025
	 Das Gupta, T., Martin-Monier, L., Yan, W. et al. Self-assembly of nanostructured glass metasurfaces via templated fluid instabilities. Nat. Nanotechnol. 14, 320–327 (2019). https://doi.org/10.1038/s41565-019-0362-9

	`hdessus_3d.m`

This code file simulates the evolution of a film’s thickness over time using a set of partial differential equations (PDEs) applied to the system. The PDEs describe the evolution of the thickness h(t,()\ where ( represents the spatial coordinates of the substrate.
 
Main Features:
	Initial Conditions: The initial height profile of the film is defined as a function of the spatial coordinates /Theta_X and /Theta_Y.
	Differential Operators: The code utilizes Fourier-based differentiation to compute spatial derivatives. This is followed by the solution of the time evolution equation using either a linear solver (`ode45`) or a stiff solver (`ode15s`).
	Numerical Integration: The solver integrates over time using ODE solvers. It uses a matrix form for the evolution, and data is reshaped and visualized over time.
	Mass Conservation: The mass conservation is checked during the time steps to ensure that no significant error occurs in mass calculations.
	Results Visualization: The results are visualized in 3D, with a video output showing the height profile evolution over time.

	`hevolplandessus3d_s.m`

This function is used to calculate the time derivative \frac{dh}{dt} based on spatial derivatives of the film's thickness. The thickness is computed using Fourier transforms of the spatial data.
Main Features:
	Differential Operators: The function computes derivatives of the thickness and other variables using Fourier differentiation (`fourdifft3d`).
	Evolution Equation: The derivative of the height is computed based on interactions of the thickness with its spatial derivatives (1st, 2nd, etc.). The equation incorporates non-linear interactions of the thickness and its gradients in both directions (X and Y).
	Fourier Transforms: Fourier transforms are used to calculate the derivatives, leveraging the periodic nature of the problem for efficient computation.

	`fourdifft3d.m`

This function computes the m-th derivative of a 2D function using Fourier transforms. The Fourier method is efficient for periodic problems like this one.
Main Features:
	Fourier Differentiation: The function applies the Fourier transform to the input matrix and computes the required spatial derivative in Fourier space, then converts it back to physical space using the inverse Fourier transform.
	Input and Output: The input is a matrix of function values, and the output is the m-th spatial derivative of the function.
	Use in the Main Code: This function is used in `hevolplandessus3d_s.m` to compute the necessary spatial derivatives for the film evolution equation.


	`2d_substrate_van_der_waals_born_repulsion.mph`

This COMSOL file simulates the 3D dewetting of a thin film on an inverted pyramid under the combined influence of Laplce pressure and destabilizing Van der Waals Interactions.
Main Features 
	General Form PDE: The function applies the Fourier transform to the input matrix and computes the required spatial derivative in Fourier space, then converts it back to physical space using the inverse Fourier transform.
	Materials and Geometry: Directly extrapolated from work exposed in the following work.

