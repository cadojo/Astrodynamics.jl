#
# Plot orbits
#

function multibody_plot3d(sols::MultibodyPropagationResult; bodies=1:length(sols.step[1].body), kwargs...)
   
    # Referencing:
    # [1] https://discourse.julialang.org/t/smart-kwargs-dispatch/14571/15

    # Set default kwargs (modified from [1])
    defaults = (;   formatter=:scientific,
                    legend=:topleft,
                    top_margin=5px,
                    left_margin=[5mm 0mm],
                    right_margin=[5mm 0mm],
                    bottom_margin=5px,
                    size=(900, 600),
                    zrotation=90,
                    yrotation=17,
                    xrotation=-4,
                    xlabel="X Position (km)", 
                    ylabel="Y Position (km)",
                    zlabel="Z Position (km)",
                    title ="NBody Positions vs. Time")
    options = merge(defaults, kwargs)

    fig = plot()
    for i = bodies

        plot!(fig, ustrip.(u"km", map(x -> x.body[i].r̅[1], sols.step)), 
                   ustrip.(u"km", map(x -> x.body[i].r̅[2], sols.step)), 
                   ustrip.(u"km", map(x -> x.body[i].r̅[3], sols.step)), 
                   label=string("Body ", i))

    end
    plot!(fig; options...)

    display(fig)

end