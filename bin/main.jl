ENV["GENIE_ENV"] = "prod"

@info "pwd(): $(pwd())"
@info "@__DIR__: $(@__DIR__)"
@info "$(readdir())"

using Pkg
@info(Pkg.status())

cd(dirname(@__DIR__))
# pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir
pwd() == @__DIR__ # allow starting app from bin/ dir

env = ENV["GENIE_ENV"]
@info "After init"
@info "Genie ENV: $env"
@info "pwd(): $(pwd())"
@info "@__DIR__: $(@__DIR__)"
@info "$(readdir())"

using GenieExperiments
push!(Base.modules_warned_for, Base.PkgId(GenieExperiments))
GenieExperiments.main()