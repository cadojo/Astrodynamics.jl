"""
Handles calculations relevant to the Circular Restricted
Three Body Problem.
"""
module ThreeBody

using Reexport

using ..CommonTypes: @dowhile
@reexport using ..CommonTypes
using ..TwoBody

include("../Misc/DocStringExtensions.jl")
include("../Misc/UnitfulAliases.jl")

using LinearAlgebra: norm, cross, ×, dot, ⋅, I
using StaticArrays: SVector, @SVector, SMatrix, @SMatrix
using DifferentialEquations, ModelingToolkit
using ComponentArrays
using Roots

export ThreeBodyState, NondimensionalThreeBodyState, ThreeBodySystem
export time_scale_factor,
       nondimensionalize_length,
       nondimensionalize_velocity,
       nondimensionalize_time,
       nondimensionalize_mass_parameter,
       nondimensionalize,
       redimensionalize_length,
       redimensionalize_velocity,
       redimensionalize_time,
       redimensionalize,
       potential_energy, 
       jacobi_constant,
       lagrange,
       halo_analytic,
       halo,
       Hᵤ, 
       accel,
       halo_numerical_tic!,
       reset_halo!,
       state_transition_dynamics,
       nondimensional_radius,  
       inertial, 
       synodic,
       convert,
       promote
       
include("ThreeBodyStates.jl")
include("ThreeBodyCalculations.jl")
include("Halo.jl")

end