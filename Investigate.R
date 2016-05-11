#
library(dplyr)

# The directory with all the files
setwd("~/Training/Coursera/TidyDataAssignment/UCI_HAR_Dataset")

# let's have a look at a few files. This loads data sets in R
# so one can manually have a look, get an idea of the data
# Added some checks to ensure the dimensions are consistent
# and the data is as expected, e.g. double or integer.

setwd("./test")
fname <- "X_test.txt"
x_test <- tbl_df(read.table(fname, colClasses = "double"))
mydim <- dim(x_test)
print(fname)
print(mydim)
num_rows = mydim[1]
if (mydim[2] != 561) stop(fname, ": X-dimension should be 561")
if (anyNA(x_test)) stop(fname, ": at least one NA value")


fname <- "y_test.txt"
y_test <- tbl_df(read.table(fname, colClasses = "integer"))
mydim <- dim(y_test)
print(fname)
print(mydim)
print(unique(y_test))
if (mydim[1] != num_rows) stop(fname, ": wrong number of rows")
if (mydim[2] != 1) stop(fname, ": X-dimension should be 1")
if (anyNA(y_test)) stop(fname, ": at least one NA value")


fname <- "subject_test.txt"
subj_test <- tbl_df(read.table(fname, colClasses = "integer"))
mydim <- dim(subj_test)
print(fname)
print(mydim)
print(unique(subj_test))
if (mydim[1] != num_rows) stop(fname, ": wrong number of rows")
if (mydim[2] != 1) stop(fname, ": X-dimension should be 1")
if (anyNA(subj_test)) stop(fname, ": at least one NA value")


setwd("./Inertial Signals")
for (filename in dir()) {
    sigfile <- tbl_df(read.table(filename, colClasses = "double"))
    mydim <- dim(sigfile)
    print(mydim)
    if (mydim[1] != num_rows) stop(filename, ": wrong number of rows")
    if (mydim[2] != 128) stop(filename, ": X-dimension should be 128")
    if (anyNA(sigfile)) stop(fname, ": at least one NA value")
}

setwd("../..")

# Not saying this is elegant but again, this is just to
# explore/investigate the data. So we copy & paste the code
# from above, now for the train files.
# Don't overcomplicate things ;-)

setwd("./train")
fname <- "X_train.txt"
x_test <- tbl_df(read.table(fname, colClasses = "double"))
mydim <- dim(x_test)
print(fname)
print(mydim)
num_rows = mydim[1]
if (mydim[2] != 561) stop(fname, ": X-dimension should be 561")
if (anyNA(x_test)) stop(fname, ": at least one NA value")


fname <- "y_train.txt"
y_test <- tbl_df(read.table(fname, colClasses = "integer"))
mydim <- dim(y_test)
print(fname)
print(mydim)
print(unique(y_test))
if (mydim[1] != num_rows) stop(fname, ": wrong number of rows")
if (mydim[2] != 1) stop(fname, ": X-dimension should be 1")
if (anyNA(y_test)) stop(fname, ": at least one NA value")


fname <- "subject_train.txt"
subj_test <- tbl_df(read.table(fname, colClasses = "integer"))
mydim <- dim(subj_test)
print(fname)
print(mydim)
print(unique(subj_test))
if (mydim[1] != num_rows) stop(fname, ": wrong number of rows")
if (mydim[2] != 1) stop(fname, ": X-dimension should be 1")
if (anyNA(subj_test)) stop(fname, ": at least one NA value")


setwd("./Inertial Signals")
for (filename in dir()) {
    sigfile <- tbl_df(read.table(filename, colClasses = "double"))
    mydim <- dim(sigfile)
    print(mydim)
    if (mydim[1] != num_rows) stop(filename, ": wrong number of rows")
    if (mydim[2] != 128) stop(filename, ": X-dimension should be 128")
    if (anyNA(sigfile)) stop(fname, ": at least one NA value")
}

setwd("../..")

fname <- "features.txt"
featurevec <- tbl_df(read.table(fname,
                                colClasses = c("integer", "character")))
mydim <- dim(featurevec)
print(fname)
print(mydim)
if (mydim[1] != 561) stop(filename, ": number of rows should be 561")
if (mydim[2] != 2) stop(filename, ": X-dimension should be 2")
if (anyNA(sigfile)) stop(fname, ": at least one NA value")


fname <- "activity_labels.txt"
featurevec <- tbl_df(read.table(fname,
                                colClasses = c("integer", "character")))
mydim <- dim(featurevec)
print(fname)
print(mydim)
if (mydim[1] != 6) stop(filename, ": number of rows should be 6")
if (mydim[2] != 2) stop(filename, ": X-dimension should be 2")
if (anyNA(sigfile)) stop(fname, ": at least one NA value")


# The end.