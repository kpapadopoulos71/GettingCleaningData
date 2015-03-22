#
# run_analysis.R
# March 20, 2015
# Kostas Papadopoulos
#

# Read the file that contains the columns of the x_ file
# Then convert it into a vector, so it can be used for column headers
features_ds<-read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
v_features<-as.vector(features_ds$V2)

# Read all the input files into a data table, from the working directory, and
# name the columns of the data set
# Training Data
data<-read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
colnames(data)[1]<-"subject"

data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"))
colnames(data)[2]<-"activity"

data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/x_train.txt", col.names=v_features))

# Training / Inertial data
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", col.names=c(1:128)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", col.names=c(129:256)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", col.names=c(257:384)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", col.names=c(385:512)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", col.names=c(513:640)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", col.names=c(641:768)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", col.names=c(769:896)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", col.names=c(897:1024)))
data<-cbind(data, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", col.names=c(1025:1152)))

# Read all test data in a separate data table
# Test Data
data_test<-read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
colnames(data_test)[1]<-"subject"

data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"))
colnames(data_test)[2]<-"activity"

data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/x_test.txt", col.names=v_features))

# Test / Inertial data
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", col.names=c(1:128)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", col.names=c(129:256)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", col.names=c(257:384)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", col.names=c(385:512)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", col.names=c(513:640)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", col.names=c(641:768)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", col.names=c(769:896)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", col.names=c(897:1024)))
data_test<-cbind(data_test, read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", col.names=c(1025:1152)))

# Merge the test data table into the train data set, order to create a unique data set.
data<-rbind(data,data_test)

# Calculate the Mean and Standard Deviation for every column 
# in the unified data set, and store it in a dataset
summary_ds<-data %>%
  summarise_each(funs(mean,sd), (3:1715))

# Create a new data table with the Activity Descriptions
activity_names<-read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
colnames(activity_names)[1]<-"activity"
colnames(activity_names)[2]<-"activity_name"

# Merge the activity data set with the main data set, and assign it
# back to the original data set
data<-merge(data, activity_names, by.x="activity", by.y="activity", all=TRUE)

# Assign descriptive label names to the data set variables


# Create new data set that is the average of each variable
# grouped by activity and subject
output_data<-data %>%
  group_by(activity, subject) %>%
  summarise_each(funs(mean), (3:1715))

write.table(output_data, file="output_ds.txt", row.names=FALSE)

# End of Script



