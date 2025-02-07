A repository gathering code to simulate the time evolution of a film on an inclined substrate under the combined effect of **Laplace Pressure** and **Van der Waals Interactions**.

## **Overview**  
The provided code simulates the **dewetting process of thin films** under specific conditions. It models the evolution of film thickness over time through **partial differential equations (PDEs)** that account for **intermolecular interactions** and **surface tension forces**.  

### **Key Features**  
- **Fourier-based Methods**: Used to calculate spatial derivatives efficiently.  
- **Numerical Integration**: ODE solvers simulate the time-dependent evolution of film thickness.  
- **Mass Conservation**: Ensures no significant mass loss during the simulation.  
- **3D Visualization**: Results are presented visually to analyze film morphology during dewetting.  

### **Related Publications**  
For more information regarding the associated works, please refer to:  

1. **L. Martin-Monier, P. G. Ledda, P. L. Piveteau, F. Gallaire, and F. Sorin**  
   *Prediction of Self-Assembled Dewetted Nanostructures for Photonics Applications via a Continuum-Mechanics Framework*,  
   *Phys. Rev. Applied 16, 034025*.  
   [Link](https://journals.aps.org/prapplied/abstract/10.1103/PhysRevApplied.16.034025)  

2. **Das Gupta, T., Martin-Monier, L., Yan, W. et al.**  
   *Self-assembly of nanostructured glass metasurfaces via templated fluid instabilities*,  
   *Nat. Nanotechnol. 14, 320–327 (2019)*.  
   [Link](https://doi.org/10.1038/s41565-019-0362-9)  

---

## **Code Files and Their Functions**  

### **1. `hdessus_3d.m`**  

This script simulates the evolution of a thin film's thickness over time using **partial differential equations (PDEs)** applied to the system.  

#### **Main Features**  
- **Initial Conditions**: The initial height profile is defined as a function of the spatial coordinates **θ (Theta_X, Theta_Y)**.  
- **Differential Operators**: Uses **Fourier-based differentiation** to compute spatial derivatives.  
- **Numerical Integration**: The solver integrates the evolution equation using either a **linear solver (`ode45`)** or a **stiff solver (`ode15s`)**.  
- **Mass Conservation**: Ensures mass consistency over time.  
- **Results Visualization**: Outputs 3D visualizations, including video representation of the evolving height profile.  

---

### **2. `hevolplandessus3d_s.m`**  

This function calculates the **time derivative** \(\frac{dh}{dt}\) based on spatial derivatives of the film’s thickness using Fourier transforms.  

#### **Main Features**  
- **Differential Operators**: Computes derivatives using **Fourier differentiation (`fourdifft3d`)**.  
- **Evolution Equation**: Incorporates non-linear interactions of film thickness and its gradients (first-order, second-order, etc.).  
- **Fourier Transforms**: Leverages the periodic nature of the problem for efficient computation.  

---

### **3. `fourdifft3d.m`**  

Computes the **m-th derivative** of a **2D function** using **Fourier transforms**, an efficient method for periodic problems.  

#### **Main Features**  
- **Fourier Differentiation**: Applies Fourier transform to compute spatial derivatives and converts back to physical space using **inverse Fourier transform**.  
- **Input & Output**:  
  - **Input**: A matrix of function values.  
  - **Output**: The **m-th spatial derivative** of the function.  
- **Use in the Main Code**: This function is called in **`hevolplandessus3d_s.m`** to compute spatial derivatives for the film evolution equation.  

---

### **4. `2d_substrate_van_der_waals_born_repulsion.mph`**  

A **COMSOL** simulation file for **3D dewetting of a thin film** on an **inverted pyramid** under the influence of **Laplace pressure** and **Van der Waals interactions**.  

#### **Main Features**  
- **General Form PDE**: Uses **Fourier transforms** to compute spatial derivatives efficiently.  
- **Materials & Geometry**: Directly extrapolated from the research cited above.  
