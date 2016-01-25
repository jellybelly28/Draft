Code Book

Introduction of the Original Data Set

This is the Codebook for the Assignment: Getting and Cleaning Data Course Project. The data set is the UCI Human Activity Recognition Using Smartphones Data Set.

Brief Description of the Study
The data is collected from Samsung Galaxy S smartphone accelerometers.

Technical Information of the original files:
Included in the original files were:
README.txt: a description of the dataset folder
activity_labels.txt: the labeling of the activity variables
features.txt: A list of the variables for the measurements 
features_info.txt: An explanation of the list of features
Folder Test and Train

Folder Test contained:
subject_test.txt: Data of the subjects in the test group
X_test.txt: Data of the measurementsof the subjects in the test group
y_test.txt: Data of the activities of the subjects in the test group
Folder Inertial Signals

Folder Train contained
subject_train.txt: Data of the subjects in the train group
X_train.txt: Data of the measurements of the subjects in the train group
y_train.txt: Data of the activities of the subjects in the train group
Folder Inertial Signals

Structure of the original data set
Upon examining the data files, all the files partially named, "test" belong to the test subjects and all the files partially named "train" belong to the train subjects.
The files with partial names of "X", "y", and "subject" correspond to various data points of the same subjects.

Introduction of Getting and Cleaning the Data

The script run_analysis.R performs several steps (5) in order to clean the original data set.Before the first step was started, the data was downloaded, unzipped, and read in R. Packages "dplyr" and "data.table" were used.

Of note, files containing "Test" had 2947 rows, and files containing "Train" had 7352 rows.

1) The training and test sets are merged to create one data set. 
	
In order to do this, each test and train dataset are merged together first. For example, in the files containing "X" which contains the measurements, the test and training datafiles are merged together with rbind. This creates a combined data file of both the test and train measurements. Each combined dataset is organized so that the "Test" data is on the top and the "Train" data is on the bottom. After this is completed for each type of file, all three files are merged together for a large data set that contains the Subject, Activity, and Measurement/Results. This final large data set is called Combo_data_master


Of note, the column names of Combo_data_master has been changed to reflect the actual measurements and results by using the original features.txt which contained the measurement variables. 

2)The measurements of the mean and standard deviation are extracted into a new data set.

Using grep, the measuremetns of mean and standard deviations are extracted into the data frame- Extracted_data. In addition, the columns for subject and activity are added to this data frame.

3) Descriptive activies names are used to name the activities in the data set.

Using the activities_labels.txt file, the original activitiy variables "1, 2, 3, 4, 5, 6" are transformed to their respective activity labels.

 1= Walking
 2= WalkingUpstairs
 3= WalkingDownstairs
 4= Sitting
 5= Standing
 6= Laying 

4)The data set is labeled with appropriate descriptive variable names.

In this step, punctuations such as periods, commas or dashes are removed. In addition, characters, "f" and "t" are further described with "freq" or "time".

5) A second, independent tidy dataset with average of each variable for each activity and subject is created. A csv file called Tidydataset is also created.

Using the dplyr function, the second tidy dataset is created. The dataset is called: Tidydataset.

 
Variables

X_test: the data table of the X_test.txt file
Y_test: the data table of the Y_test.txt file
X_train: the data table of the X_train.txt file
Y_train: the data table of the Y_train.txt file
subject_test: the data table of the subject_test.txt file
subject_train: the data table fo the subject_train.txt file

features: the features files- features.txt

Combo_data: combining the X files for both test and train( X_test+X_train); contains 10299 obs of 561 variables
Combo_dataY: combining the Y files for both test and train (Y_test + Y_train); contains 10299 obs of 1 variable
Combo_datasubject:  combining the subject files for both test and train(subject_test+subject_train); contains 10299 obs of 1 variable

Combo_data_master: Combining all three combo_data files together (Combo_data + Combo_dataY +Combo_datasubject); contains 10299 obs of 563 variables

Extracted_data: the extracted data containing the mean and standard deviation measurements along with columns for Subject and Activity; contains 10299 obs of 81 variables

Tidydataset: the 2nd independent data set with the average of each variable for each activity and subject; contains 180 observations and 81 variables

Tidydataset.txt: the txt file of the 2nd independent data set with average of each variable for each activity and subject

