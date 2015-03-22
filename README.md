run_analysis.R
===================

The script is using a predefined set of data regarding Samsung's Galaxy S smartphone usage of the accelerometer.

There is a set of files that can be used as lookups:
 - activity_labels.txt :  Includes the descriptions of the Activity codes for each row of data
 - features.txt : Includes a list of variable names, as these variables are part of the files X_Train.txt and X_Test.txt
 - subject_tests.txt / subject_train.txt: The file contains the Id of the subject per record of the data
 - y_train.txt / y_test.txt: A list of the activity that took place, per record of data
 
There are two sets of main data:  A set created while testing the device and functionality, and another set created
during training sessions.  Each set includes nine (9) files:
 - body_acc_x_*.txt
 - body_acc_y_*.txt
 - body_acc_z_*.txt
 - body_gyro_x_*.txt
 - body_gyro_y_*.txt
 - body_gyro_z_*.txt
 - total_acc_x_*.txt
 - total_acc_y_*.txt
 - total_acc_z_*.txt
where * can be train or test

In this script are composing a main data set, that includes all the partial data sets that have introduced.
More specifically, we need to construct a data set that includes:
 - Subject code:  Which subject of the experiment produced the data of that record
 - Activity code and Description:  The type of activity that produced the record
 - A vector with 561 columns of time and frequency domain variables
 - A vector of 128 x 3 (x/y/z) columns of estimated body acceleration  
 - A vector of 128 x 3 (x/y/z) columns of total acceleration  
 - A vector of 128 x 3 (x/y/z) columns of Triaxial Angular velocity from the gyroscope.
 
In order to do that we:
 - Create a vector from the features.txt file, so we can use it to create the column headers for the frequency domain variables.
 - Create a data set based on the Training data, by:
   -- Create a table with the data of the subject.txt file, in order to specify the subject
   -- Append columns with the data from the y_train / y_test file, in order to specify the activity.
   -- Append 561 columns from the x_train / x_test file with the time and frequency domain variables.
   -- Append columns from the rest of the files that include acceleration and velocity variables
 - Repeat the above steps, for the Test data, and create a new data set
 - Merge the two data sets by appending rows of the Test data set to the Train data set.
 - Calculate the mean and standard deviation of each column and add it in a new data set
 - Include the Activity description to the main data set by merging (joining) the main data set with 
   a new one based on the activity file.
 - Calculate the mean of each column, grouped by Activity and Subject, and store in a new data set.
 - Output the final data set by writing it in a file (output_ds.txt).
 