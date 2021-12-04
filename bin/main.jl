ENV["GENIE_ENV"] = "prod"

@info "pwd(): $(pwd())"
@info "@__DIR__: $(@__DIR__)"
@info "$(readdir())"

using Pkg
Pkg.status()

pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir
cd(dirname(@__DIR__))

env = ENV["GENIE_ENV"]
@info "After init"
@info "Genie ENV: $env"
@info "pwd(): $(pwd())"
@info "@__DIR__: $(@__DIR__)"
@info "$(readdir())"

using GenieExperiments
push!(Base.modules_warned_for, Base.PkgId(GenieExperiments))
GenieExperiments.main()