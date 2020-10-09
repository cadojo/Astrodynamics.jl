module TwoBodyUnitTests

using Test
using Astrodynamics

@testset "Transformations" begin
    
    r̅ = [0.0, 11681.0, 0.0] * u"km"
    v̅ = [5.134, 4.226, 2.787] * u"km/s"
    orbit = Orbit(r̅, v̅, Earth)

    @test orbit.a ≈ 24509.272364065997 * u"km"
    @test orbit.e ≈ 0.7234527725236475
    @test orbit.i ≈ 2.6442542356744734 * u"rad"
    @test orbit.ν ≈ 1.5707355666179315 * u"rad"

    @test Orbit(map(x->getfield(orbit, x), [:e,:a, :i, :Ω, :ω, :ν])..., orbit.body) ≈ orbit

    e      =  0.3      * u"rad"
    a      =  15000.   * u"km" + 1.0u"Rearth"
    i      =  10.      * u"°"
    Ω      =  0.       * u"°"
    ω      =  10.      * u"°"
    ν      =  0.       * u"°"
    orbit  =  Orbit(e, a, i, Ω, ω, ν, Earth)

    @test isapprox(orbit, Orbit(orbit.r̅, orbit.v̅, orbit.body), atol=1e-6)

end

@testset "Kepler" begin
    
    r̅ = [0.0, 11681.0, 0.0]u"km"
    v̅ = [5.134, 4.226, 2.787]u"km/s"
    orbit = Orbit(r̅, v̅, Earth)

    @test kepler(orbit, orbital_period(orbit)) ≈ orbit

end

end