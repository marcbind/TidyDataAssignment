# TidyDataAssignment

## Scripts

The repository contains two script: Investigate.R and run_analysis.R .

The "Investigate" script was originally just loading some data files to understand the data and how the various files relate to each other, e.g. by identifying common dimensions. The script was later enhanced by checking the data set dimensions are as expected, e.g. 561 columns for X_test/_train or that all the files in the test folder have the same number of rows. It also checks against NA data when read into R as a specific type, e.g. double or integer.

The "run_analysis" script is the main processing script. It requires the "dplyr" and "stringr" libraries to be installed on the system. The script must be modified to change it's working directory where the UCI HAR Dataset resides; you find the "setwd" at the top of the script.

Another part that may require adjustment is how the "is_mean_std" variable is set. This is a 561 element logical vector and each element corresponds to the variable name in "feature.txt" as the same position. The submitted script selects 18 variables: the mean and standard deviation of basic acceleration and gyroscope variables in the time ("t") domain.

The rest of the "run_analysis" script uses "is_mean_std" to select the appropriate columns from the X_test and X_train data sets. The script adds to each of these data sets the corresponding "y" (i.e. the activity label) and "subject" (i.e. the ID of the volunteer being measured) data as new columns.

Finally both the "test" and "train" data is combined (via rbind). Then for all the volunteer/activity combinations the average (i.e. the mean) is calculated for all the variables we selected with "is_mean_std".

Somewhere along this processing we also replaced the activity codes (1..6) with descriptive text.

## Files

This repo only contains "Investigate.R" and "run_analysis.R" plus the "Codebook.md" and this "README.md" file. The original data from UCI can be found under

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   
## Acknowledgement
All the work to execute the experiment, collect the data, filter noise and so on should be recognized - it allows us to have our fun with Data analytics ;-)

The work was done by Smartlab - Non Linear Complex Systems Laboratory at DITEN - Universite degli Studi di Genova.

Reference: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

