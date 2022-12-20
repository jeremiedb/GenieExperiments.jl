(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using GenieExperiments
const UserApp = GenieExperiments
GenieExperiments.main()
