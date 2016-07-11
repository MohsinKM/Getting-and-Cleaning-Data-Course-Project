# Written by KM Mohsin, Usage of this codes
# > path="..../.../data"   #please note, not to use "/" at the of directory. It has been taken care of
# in the following code.
# >tidy_dat<-run_analysis(path)

run_analysis<-function(path) {
setwd(path)
library(plyr)

# Step 1: Merges the training and the test sets to create one data set. 
X_Train <<- read.table(paste0(path,"/train/X_train.txt"))
X_Test  <<- read.table(paste0(path,"/test/X_test.txt")) 
merged <- rbind(X_Train, X_Test)
feature_Names <- read.table("features.txt")[, 2]
names(merged) <- feature_Names


# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# looking for mean() or std() in names of merged data
index <- grep("(mean|std)\\(\\)", names(merged)) 
mean_std_cols <- merged[, index]  # 66 cols founds of 10299 rows

y_Train <<- read.table(paste0(path,"/train/y_train.txt"))
y_Test  <<- read.table(paste0(path,"/test/y_test.txt"))
y_Merged <- rbind(y_Train, y_Test)[, 1]


# Step 3: Uses descriptive activity names to name the activities in the data set

activity_Names <-
    c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activity_Names[y_Merged]


# Step 4: Appropriately labels the data set with descriptive variable names.
names(mean_std_cols) <- gsub("^t", "Time", names(mean_std_cols))
names(mean_std_cols) <- gsub("^f", "Frequency", names(mean_std_cols))
names(mean_std_cols) <- gsub("-mean\\(\\)", "Mean", names(mean_std_cols))
names(mean_std_cols) <- gsub("-std\\(\\)", "StdDev", names(mean_std_cols))
names(mean_std_cols) <- gsub("-", "", names(mean_std_cols))
names(mean_std_cols) <- gsub("BodyBody", "Body", names(mean_std_cols))


# Step 5:From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

subject_Train <<- read.table(paste0(path,"/train/subject_train.txt"))
subject_Test  <<- read.table(paste0(path,"/test/subject_test.txt"))
subjects <- rbind(subject_Train, subject_Test)[, 1]
tidy_data <- cbind(Subject = subjects, Activity = activities, mean_std_cols)


# Column means for all but the subject and activity columns
my_ColMeans <- function(data) { colMeans(data[,-c(1,2)]) }
tidy_Means <- ddply(tidy_data, .(Subject, Activity), my_ColMeans)
names(tidy_Means)[-c(1,2)] <- paste0("Mean", names(tidy_Means)[-c(1,2)])

write.table(tidy_Means, "tidy_Means.txt", row.names = FALSE)
tidy_Means
}