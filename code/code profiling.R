# Tools for code profiling
rm(list = ls())

# utils::Rprof() ----

## Profile snowboot::sample_about_one_seed() ----
library(snowboot)

# Example data to run the function on
ntwrk = artificial_networks[[1]]

# For relatively fast functions, repeat calculations nrep times.
# In this case, let it be the order of the network (order = number of nodes).
nrep = ntwrk$n

# See the time it takes
system.time(for (i in 1:nrep) {
    sample_about_one_seed(net = ntwrk, seed = i, n.wave = 5)
})

# See the time each step takes
Rprof(tmp <- tempfile())
for (i in 1:nrep) {sample_about_one_seed(net = ntwrk, seed = i, n.wave = 5)}
Rprof(NULL)
summaryRprof(tmp)



## Profile funtimes::causality_pred() ----
library(funtimes)

# Example data to run the function on
?funtimes::causality_pred
Canada <- vars::Canada

# For relatively fast functions, repeat calculations nrep times.
# In this case, we can also slow down the function using a
# higher number of bootstraps or longer time series.

# See the time it takes
system.time(
    causality_pred(Canada[,1:2], cause = "e",
                   lag.max = 5, p.free = TRUE, B = 1000L)
)

# See the time each step takes
Rprof(tmp <- tempfile())
causality_pred(Canada[,1:2], cause = "e",
               lag.max = 5, p.free = TRUE, B = 1000L)
Rprof(NULL)
summaryRprof(tmp)

d = summaryRprof(tmp)
d$by.total[order(d$by.total$self.pct), ]

# profvis ----
# See https://rstudio.github.io/profvis/
library(profvis)
profvis(causality_pred(Canada[,1:2], cause = "e",
                       lag.max = 5, p.free = TRUE, B = 1000L))
# In the flame graph, the horizontal direction represents time in milliseconds,
# and the vertical direction represents the call stack.


# parallel ----

# E.g., optional parallel computing is allowed in the function below
# (see the argument cl)
?funtimes::causality_pred

# Typical decisions
# A) parallel bootstraps (if need to compute fast for 1 big time series or large B)
# or
# B) parallelize the whole function (if need to compute fast for many time series).

## Simple example ----

# Sequential long operation
system.time(
    sapply(1:1000, function(i) {
        x = rnorm(100000)
        mean(x) / sd(x)
    })
)

# Same operation executed in parallel
library(parallel)
# Create cluster
cl <- parallel::makeCluster(parallel::detectCores())
# If needed, pass objects from the environment to the nodes
# parallel::clusterExport(cl,
#                         varlist = c("net"),
#                         envir = environment())
system.time(
    parallel::parSapply(cl, 1:1000, function(i) {
        x = rnorm(100000)
        mean(x) / sd(x)
    })
)

# See the time it takes
system.time(
    causality_pred(Canada[,1:2], cause = "e",
                   lag.max = 5, p.free = TRUE, B = 1000L, cl = cl)
)

stopCluster(cl)


# References ----
# Jonathan Dursi. Beyond Single-Core R
# https://ljdursi.github.io/beyond-single-core-R/#/
# particularly
# https://ljdursi.github.io/beyond-single-core-R/#/26
# and forward.

# Roger D. Peng. R Programming for Data Science
# https://bookdown.org/rdpeng/rprogdatascience/parallel-computation.html