# see the README file for some overview over the scripts
library(dplyr)
library(stringr)

# The directory with all the files. Update accordingly.
setwd("~/Training/Coursera/TidyDataAssignment/UCI_HAR_Dataset")

# The Task(s):
# 1: Merges the training and the test sets to create one data set.
# 4: Appropriately labels the data set with descriptive variable names.
#
# First lets use feature.txt to provide good names to the columns
# of the X_test/train data and to select which columns we want.

features <- read.table("features.txt", colClasses = "character")[, "V2"]

# The feature names are chosen reasonably by the original authors
# and we keep the upper/lowercase. I do remove the brackets (
# and ) though and replace comma and hyphen with underscore.
# Remember: beauty is in the eye of the beholder ;-)

features <- features %>%
            gsub(pattern = "[()]", replacement = "") %>%
            gsub(pattern = ",", replacement = "_") %>%
            gsub(pattern = "-", replacement = "_")

# Part of this task is to extract only the measurements on the mean
# and standard deviation for each measurement. We create a logical
# vector by searching for Variable names that contain "-mean" or
# "-std" (which after our translation is "_mean", "_std").
# Note 1:
# This is removing the last few variables like "angle(X,gravityMean)".
# If these should be contained we can simply remove the underscore
# in the grepl pattern.
# Note 2:
# For simplicity/readability we do restrict the logical vector further,
# to the "original" variables, i.e. basic Acceleration and Gyroscope
# data in the time ("t") domain.
# The code further down below is generic and the selection is solely
# controlled by is_mean_std.
is_mean_std <- grepl("_mean|_std", features, ignore.case = TRUE) &
               grepl("^t[a-zA-Z]*(Acc_|Gyro_)", features)


# Reduce the feature vector names
col_name_mean_std <- features[is_mean_std]


# Read in all the test data files.
# We then reduce x_test to the variables selected above.
# Name the columns/variables with col_name_mean_std from above.
# Then add the subject_test (the id of the volunteer)
# and the y_test (the activity code) as columns to the
# X_test data.

setwd("./test")
x_test <- tbl_df(read.table("X_test.txt", colClasses = "double"))
y_test <- tbl_df(read.table("y_test.txt", colClasses = "integer"))
subj_test <- tbl_df(read.table("subject_test.txt", colClasses = "integer"))
setwd("..")

# Use this vector to reduce our x_test data frame
x_test <- x_test[, is_mean_std]

# Place the feature names as variable/colum names into x_test.
# The assumption here is that something like
# "1 tBodyAcc-mean()-X" in features.txt means the 1st column variable
# is tBodyAcc-mean()-X. From a quick inspection it seems that the
# number "N" is in the Nth row, so the logic should be fine.
colnames(x_test) <- col_name_mean_std

# Now add the y_test column as "Activity" and the subj_test as
# "Volunteerid" to the x_test data frame.
x_test <- x_test %>%
          mutate(Activity = y_test$V1, Volunteerid = subj_test$V1)


# Okay, repeat the above steps for the "train" data
setwd("./train")
x_train <- tbl_df(read.table("X_train.txt", colClasses = "double"))
y_train <- tbl_df(read.table("y_train.txt", colClasses = "integer"))
subj_train <- tbl_df(read.table("subject_train.txt", colClasses = "integer"))
setwd("..")

x_train <- x_train[, is_mean_std]
colnames(x_train) <- col_name_mean_std
x_train <- x_train %>%
           mutate(Activity = y_train$V1, Volunteerid = subj_train$V1)


# now lets bind the two data frame together, i.e. rbind them
x_total <- rbind(x_test, x_train)


# 3: Uses descriptive activity names to name the activities in the data set
# We use the translation given with activity_labels.txt
x_total$Activity <- x_total$Activity %>%
    str_replace_all(c("1" = "Walking", "2" = "Walk_Upstairs",
                      "3" = "Walk_Downstairs", "4" = "Sitting",
                      "5" = "Standing", "6" = "Laying"))


# Let's write this out for review
# write.csv(x_total, "./x_total_meanstd.csv")

# 5 From the data set above, creates a second, independent tidy
# data set with the average of each variable for each activity
# and each subject.
avg_total <- x_total %>%
             group_by(Activity, Volunteerid) %>%
             summarize_each(funs(mean))

# As this is an exercise in tidy data, let's show off with
# the column names ;-)
colnames(avg_total) <- names(avg_total) %>%
                       sub(pattern = "^([a-z].*)$",
                           replacement = "average_\\1")


# Let's write this out too for review
write.table(avg_total, "./tidy_data_set.txt", row.name=FALSE)

# The End. Done :-)