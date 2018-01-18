library(dplyr)

################################################################################
# Set working directory
setwd("C:/Users/AljoschaK/Documents/project/")

################################################################################
# Specify paths to files

# Specify file paths of the training data including labels
train_x_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
train_y_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"

# Specify file paths of the test data including labels
test_x_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
test_y_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"

# Specify file path of the column names of the data
col_names_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"

# Specify the path to the subject ID files
train_subjects_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"

test_subjects_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"

# Specify the path to the activity mapping file
activity_mapping_path <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"

# Specify the path to the final output file
output_path <- "./Tidy_Data_Set.txt"


################################################################################
# Read data

# Read in the fixed width format training file
train_x <- read.fwf(train_x_path, widths = rep(16, 561))

# Read in the fixed width format test file
test_x <- read.fwf(test_x_path, widths = rep(16, 561))

# Read in the label for train_x
train_y <- read.table(train_y_path)

# Read in the label for test_x
test_y <- read.table(test_y_path)

# Read in the correspoding activities for the labels
activities <- read.table(activity_mapping_path)

# Read in the subject IDs
train_subjects <- read.table(train_subjects_path)
test_subjects <- read.table(test_subjects_path)

# Set the column names of both training and test data 
# Splitting the read in data on space character to have the column number in a separate column
col_names_table <- read.table(col_names_path, sep = " ")

################################################################################
# Modify data

# Only use second column of the col_names_table with the actual names
col_names <- col_names_table$V2

# Set the column names
colnames(train_x) <- col_names
colnames(test_x) <- col_names



# Merge data of training and test
all_data <- rbind(train_x, test_x)


# Extract the measurements that feature the mean and stdev for each measurement
# Note: The Objective of the Course Project can be understood that meanfreq and gravitymean are also included
# I think that these should not be included
mean_and_stdv <- all_data[,grep("(-std\\(\\)|-mean\\(\\))", colnames(all_data))]

# join activity id as new column
data_with_activity_ID <- cbind(activity_ID = rbind(train_y, test_y), mean_and_stdv)
colnames(data_with_activity_ID)[1] <- "activity_ID"
data_with_activity_names <- inner_join(data_with_activity_ID, activities,  by = c( "activity_ID" = "V1"))
# reorder and rename columns
data_with_activity_names <- data_with_activity_names[, c(1, ncol(data_with_activity_names), 3:ncol(data_with_activity_names)-1)]
colnames(data_with_activity_names)[2] <- "activity_names"

# add subject ID
data_with_act_and_sub_desc <- cbind(data_with_activity_names[1:2], subject_ID = rbind(train_subjects, test_subjects), data_with_activity_names[3:ncol(data_with_activity_names)])

# Rename Subject column
colnames(data_with_act_and_sub_desc)[3] <- "subject_ID" 

# Create a tidy data set with the average of each variable for each activity and each subject
tidy_data_set <- data_with_act_and_sub_desc %>% 
    select(-activity_ID) %>% 
    group_by(activity_names, subject_ID) %>% 
    summarise_all(funs(mean))

################################################################################
# Write tidy data to output file
write.table(tidy_data_set, file = output_path, row.names = FALSE)
