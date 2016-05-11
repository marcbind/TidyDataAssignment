# Codebook (details about the data)

## The original data / experiment

The experiments had been carried out by members of the Universita degli Studi di Genova, with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate of 50Hz.

The obtained dataset had been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

You will find the original data under

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data from the smartphone sensors had then been filtered (see the "README.txt" file in the zip file above for details) and every 128 consecutive data points have been grouped together; they form one row in the "Inertial Signals" data files. Out of each row of the acceleration and gyroscope data the original authors formed 561 calculated values, which they call a "feature vector".

## The "tidy data" processing

The 30 volunteers are identified by a number from 1 to 30; in the tidy_data file this is named the "Volunteerid". The 561 values per row of the "X_test" and "X_train" data sets are the source of our additional "tidying" processing. Each column of these data sets corresponds to the particular number/name in the "feature.txt" file. We identified values of interest by looking for

* only mean or standard deviation values, i.e. variables named with "-mean()" and "-std()". This was requested by the "tidying study sponsor" ;-)

* variables that are related to the original data, i.e. X/Y/Z acceleration and gyroscope information

* only variables from the time ("t") domain and ommitting variables from the frequency ("f") domain, which had been derived from Fourier transformation

The 2nd and 3rd restriction was introduced by the script author to provide an example how to filter; there was no explicit goal given. See the "README" file in the github repo for how to change the selection of variables in the script.

After reducing the "X_test" and "X_train" data sets to the variables of interest, and adding the activity and the volunteer id we joined both data sets to a "total" set. We then calculated the average, i.e. the mean, for every variable, for every combination of activity and volunteer. The resulting table is "tidy_data".

It should be mentioned that the original data used a number code 1..6 for the activity. As part of the tidying these numbers had been converted into the corresponding descriptions, e.g. "Walking".

## Some comments on the data

The variables selected have one advantage - it's simple to explain what they mean:

The "Acc"eleration data quantifies the acceleration, i.e. the change of speed, in each of the 3 space direction X, Y and Z.

The "Gyro"scopic data quantifies how quickly the smartphone is turned around each of the space axis.


The acceleration is measured in units of 'g', the standard gravity. The original authors do not mention further details, so let's assume g is 9.81 meter/second^2.

The gyroscope is measuring angular velocity. The unit is radians/second.

The feature vector values are normalized and bounded within [-1,1]

The acceleration variables selected for tidy_data contain "tBodyAcc" and "tGravityAcc". This goes back to the original data cleaning, applying a frequency filter to the raw acceleration data to extract the gravity (below the frequency cut off) and the estimated body acceleration (above the frequency threshold).

The exact position of X, Y and Z relative to e.g. the earth surface is not mentioned by the original authors. All we know is the smartphone was sitting at the waist. Ah well.
