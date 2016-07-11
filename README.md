# Generation of tidy data from the "Human Activity Recognition Using Smartphones Dataset" for the course,[Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning) 

**Here are the steps that must be performed before running the R script:**

1. Download the zip file from [this URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Unzip the file. 
3. locate the directory with folder named "test", "train". 
4. save the path of this directory to call run_analysis.R


**How to use this script run_analysis.R**
> path="..../.../data_directory"  
> tidy_dat<-run_analysis(path) 
please note, not to use "/" at the end of directory. It has been taken care of inside code. Code will return a tidy data and also write a file named, tidy_Means.txt for later analysis. An example of reading tidy data file is as following, 
>read.table("tidy_Means.txt", header = TRUE)

**Here are the steps taken to generate tidy data:**

1. The test and train sets have been merged. Merged data set has given appropriate activity levels. The activity identifiers were changed into sensible human-readable names. 

2. In step 2, Only the measurements on the mean and standard deviation for each measurements were kept. 

3. Descriptive activivty name is given. 

4. Appropriately labeled the data set with descriptive variable names.

5. In this final step, Using data set obtained from previous step independent tidy data set has been generated with the average of each variable for each activity and each subject. 

The outcome of this analysis is `tidy_Means.txt` file. 


variable naming convention is  as follows:

  Mean: time Or Frequency : measurement: mean Or StdDev: XYZ

Here, : used for separation only in this file. In original data set it appears as 'MeanFrequencyBodyAccJerkMeanZ'. In this case it is mean of frequency of BodyAccJerk and mean for z axis. 

For details on variable list see codebook.md