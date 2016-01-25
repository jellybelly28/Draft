#Getting and Cleaning Coursera Project
#Step 0 Preparation

library(dplyr)
library(data.table)
url <-
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./humanactivity")
unzip("./humanactivity", exdir = ".")
X_test <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/test/X_test.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )
Y_test <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/test/y_test.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )
X_train <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/train/X_train.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )
Y_train <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/train/y_train.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )
subject_test <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/test/subject_test.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )
subject_train <-
  tbl_df(
    read.table(
      "./UCI HAR Dataset/train/subject_train.txt",
      sep = "",
      stringsAsFactors = F,
      header = F
    )
  )


##Combine the Test_data with the Train Data together through r bind
## Of note, "Test" will be on top and "Train" data on the bottom
## akafirst 2947 rows are Test_data and last 7352 rows are Train data
Combo_data <- rbind(X_test, X_train)
Combo_dataY <- rbind(Y_test, Y_train)
Combo_datasubject <- rbind(subject_test, subject_train)

##renaming the columns of Combo_data (which contains the X database)
features <- tbl_df(read.table("./UCI HAR Dataset/features.txt"))
##remove the 1st column and transform from columns to row
features2 <- data.table(t(features[,-1]))
##Change column names of Combo_data
colnames(Combo_data) <- features2[1,]
##remove the commas from the column names
colnames(Combo_data) <- gsub(",", ".", names(Combo_data))

## 1 Combine the data sets into one data set
##assuming that all the rows line up.
Combo_data_master <- cbind(Combo_datasubject, Combo_dataY, Combo_data)
##Change the names of the first 2 Columns
colnames(Combo_data_master)[1] <- "Subject"
colnames(Combo_data_master)[2] <- "Activities"


## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
#need to make the data table into a data frame
Combo_data_master <- data.frame(Combo_data_master)
Extracted_data <-
  (Combo_data_master[, grep("mean|std", colnames(Combo_data_master))])

##add Subject & Activity columns to the front of the new database

Extracted_data$Subject <- Combo_data_master$Subject
Extracted_data$Activity <- Combo_data_master$Activities
Extracted_data <- Extracted_data[, c(80, 81, 1:79)]

## 3 Uses descriptive activity names to name activities in the extracted Dataset
##change the Activities to be more descriptive (#3)
Extracted_data$Activity[Extracted_data$Activity == 1] <- "Walking"
Extracted_data$Activity[Extracted_data$Activity == 2] <-
  "WalkingUpstairs"
Extracted_data$Activity[Extracted_data$Activity == 3] <-
  "WalkingDownstairs"
Extracted_data$Activity[Extracted_data$Activity == 4] <- "Sitting"
Extracted_data$Activity[Extracted_data$Activity == 5] <- "Standing"
Extracted_data$Activity[Extracted_data$Activity == 6] <- "Laying"

## 4 Appropriately labels the data set with descriptive variable names.
colnames(Extracted_data) <-
  gsub("^t", "Time", colnames(Extracted_data))
colnames(Extracted_data) <-
  gsub("^f", "Freq", colnames(Extracted_data))
colnames(Extracted_data) <- gsub("\\.", "", colnames(Extracted_data))
colnames(Extracted_data) <-
  gsub("\\()", "", colnames(Extracted_data))

## 5 From the data set in step 4, creates a second, independent tidy data set
##with the average of each variable for each activity and each subject.
Tidydataset <- Extracted_data %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))
write.table(Tidydataset, file = "./Tidydataset.txt", row.name=FALSE)
