"""
Circular Restricted Three-body Model tests.
"""
module PropagationTests 

using LinearAlgebra, Unitful, UnitfulAstro, GeneralAstrodynamics, Test

@testset verbose=false "R2BP Propagation" begin
    
    orbit = KeplerianOrbit(0.4, 10_000, 0, 0, 0, 0, Mars, 0.0) |> CartesianOrbit
    final = propagate(orbit; save_everystep=false)[end]

    @test_broken final.state ≈ orbit.state

    @test all(isapprox.(position_vector(final), position_vector(orbit); atol=1e-8u"km"))
    @test all(isapprox.(velocity_vector(final), velocity_vector(orbit); atol=1e-8u"km/s"))

end

@testset verbose=false "CR3BP Propagation" begin
    
    @test isperiodic(halo(SunEarth;   L=2, Az=0.0005)...)
    @test isperiodic(halo(SunMars;    L=1, Az=0.0005)...)
    @test isperiodic(halo(EarthMoon;  L=2, Az=0.0005)...)
    @test isperiodic(halo(SunJupiter; L=1, Az=0.0005)...)
    
    orbit, T = halo(SunJupiter; L=2, Az=0)
    @test isapprox.(
        monodromy(orbit, T), [
            1177.6158450389235 -43.31366732210663 0.0 247.08544503455505 227.41064838834146 0.0; 
           -1085.995406851377 40.86470821207657 0.0 -227.41064838735218 -209.97647807144125 0.0; 
            0.0 0.0 0.9966422601737439 0.0 0.0 -0.09182654535515093; 
            3446.1566018075323 -126.52938312132042 0.0 722.7945482654276 666.0424507143235 0.0;
           -2146.972890519174 79.03452084349573 0.0 -450.8572227441975 -413.95658856183604 0.0; 
            0.0 0.0 0.07300944628976104 0.0 0.0 0.99664226017845
        ]; atol=1e-2
    ) |> all
    
end

end # module