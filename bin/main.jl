ENV["GENIE_ENV"] = "prod"

@info "pwd(),: $(pwd())"
@info "@__DIR__,: $(@__DIR__)"

pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir

@info "pwd(),: $(pwd())"
@info "@__DIR__,: $(@__DIR__)"

using GenieExperiments
push!(Base.modules_warned_for, Base.PkgId(GenieExperiments))
GenieExperiments.main()