rm(list = ls())
source("code/mcfunction.R")

#Sequential long operation
system.time(
    sapply(1:1000, function(i) {
        monte_carlo_pi(100000000)
    })
)

# Took a very long time:
# Timing stopped at: 33.97 9.913 51.94
cl <- parallel::makeCluster(8)
parallel::clusterExport(cl,
                        varlist =c("monte_carlo_pi"),
                        envir = environment())
system.time(
    parallel::sapply(cl, 1:10, function(i) {
        monte_carlo_pi2(1000000)
    })
)
parallel::stopCluster(cl)