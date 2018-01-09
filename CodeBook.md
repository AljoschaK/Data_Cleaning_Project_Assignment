# Getting and Cleaning Data Course Project
## Codebook
### Author: Aljoscha K

This Codebook describes how the data of the project assignment was processed.

### 1. Data Origin
This assignment was about the processing of wearable computing data, recorded by
test persons wearing a smartphone during different activities. The smartphone 
recorded all movements in x,y and z direction producing multiple measures. 

The original data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
It includes an explanation about the variables that are given. 

A precise description can be obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The original code book was added on the end of this file.

### 2. Objective
The objective was to create a tidy data set which contains only the mean and standard deviation 
of each measurement and average these measurements for each activity and subject. 

### 3. Input Variables and Data
From the original downloaded and unzipped data following files were used: 

/train/X_train.txt
--> This file contains the first part of the wearable measurement data, originally training data. 
/test/X_test.txt
--> This file contains the second part of the wearable measurement data, originally test data. 
----> This is the original data that we want to use for calculation.

/train/y_train.txt
-->This file contains the first part of the activity ID labels, belonging to the training data. 
/test/y_test.txt
-->This file contains the second part of the activity ID labels, belonging to the test data. 
----> These IDs are used in my transformation to join the activity names to the data.

/activity_labels.txt
--> These are the actual activity labels
----> These labels are joined over the ID

/train/subject_train.txt
/test/subject_test.txt
-->These files contain the information about the subject IDs, that identify the persons who carried the wearables during measurements. 
----> This information is joined to the data during transformation.

### 4. Transformations and Scripts used
All transformations were executed within the RScript `<run_analysis.R>`. Input was the unzipped data from the source described in *1. Data Origin*.
The following steps and transformations were done: 
1. Specifying the filenames of all files that were read in and written after transformations.
2. Reading of the files with data and column and row labels
3. Assigning column names to the data
4. Merging training and test data
5. Filtering to extract only columns that contain the strings *mean()* or *std()* using regular expressions.
6. Joining activity ID and activity names as addtional columns. 
7. Adding subject ID as additional column.
8. Calculate all average values of all data columns for each subject and activity. 
9. Write calculated values into a new table saved as `<Tidy_Data_Set.csv>`. 

### 5. Variables and Data created during transformation
#### Filenames
* train_x_path: String storing the file location of the input data file
* test_x_path_path: String storing the file location of the input data file

* train_y_path: String storing the file location of the activity label IDs
* test_y_path: String storing the file location of the activity label IDs
* activity_mapping_path: String storing the file location of the activity names

* col_names_path: String storing the file location of the column (measure) names

* train_subjects_path: String storing the file location of the subject identifiers
* test_subjects_path: String storing the file location of the subject identifiers

* output_path: String storing the path to the Tidy_Data_Set.csv output file

#### Data Read In
* train_x: Data Frame where the read in data of the training data is stored
* test_x: Data Frame where the read in data of the test data is stored

* train_y: Data Frame where the activity ID labels for each row of the training data is stored
* test_y: Data Frame where the activities ID labels for each row of the test data is stored

* activities: Data Frame where the read in activity labels and their respective ID is stored for later mapping to the data

* train_subjects: Data Frame where the read in identifiers of the persons wearing the devices for each row is stored
* test_subjects:  Data Frame where the read in identifiers of the persons wearing the devices for each row is stored

* col_names_table: Data Frame where the read in column names of the measures are stored

#### Transformed Data
* col_names: Column names of the measures (only the second column of the col_names_table is needed)

* all_data: Data Frame with combined data of training and test data

* mean_and_stdv: Data Frame based on all_data, but filtered by regex to contain only columns of which the name contains either *mean()* or *std()*. 
*Note: There are more column names with the word mean but I read the task as to use only columns that are the actual mean and stdev of one measure category. There are more than one solution, I guess. I did not use them on purpose.*

* data_with_activity_ID: Data Frame based on mean_and_stdv, but with additional column containing the activity label ID of each row

* data_with_activity_names: Data Frame based on data_with_activity_ID, but with the actual activity labels joined

* data_with_act_and_sub_desc: Data Frame based on data_with_activity_names but with the subject ID added for each row

* tidy_data_set: Data Frame based on data_with_act_and_sub_desc which is aggregated by the activity name and subject ID. For each it contains the average value of each measure column. This file is used to create the output file.

### 6. Output Created
The tidy_data_set data frame is written to `<Tidy_Data_Set.csv`> which is stored on GitHub.

### 7. Original Codebook from the data source website

===================================================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
===================================================================================================
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Universit�  degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Polit�cnica de Catalunya (BarcelonaTech). Vilanova i la Geltr� (08800), Spain
activityrecognition '@' smartlab.ws 
===================================================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
- A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: http://www.youtube.com/watch?v=XOEN9W05_4A

For more information about this dataset please contact: activityrecognition '@' smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Other Related Publications:
===========================
[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz.  Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point Arithmetic. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care.   Volume 19, Issue 9. May 2013

[3] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223. 

[4] Jorge Luis Reyes-Ortiz, Alessandro Ghio, Xavier Parra-Llanas, Davide Anguita, Joan Cabestany, Andreu Catal�. Human Activity and Motion Disorder Recognition: Towards Smarter Interactive Cognitive Environments. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.  

==================================================================================================
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita and Xavier Parra. November 2013.
