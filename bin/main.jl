push!(LOAD_PATH, abspath(normpath(joinpath(@__DIR__, "../src/"))))

ENV["STARTSERVER"] = true
ENV["GENIE_ENV"] = "prod"
ENV["EARLYBIND"] = true

include("../bootstrap.jl")
    