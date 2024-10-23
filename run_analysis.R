# Download the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")

# Unzip the dataset
unzip("dataset.zip")

# Load the required data
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityName"))

# Read training data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ActivityID")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectID")

# Read test data
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ActivityID")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectID")

# Combine the training and test data
data_x <- rbind(train_x, test_x)
data_y <- rbind(train_y, test_y)
data_subject <- rbind(train_subject, test_subject)

# Extract features containing 'mean()' or 'std()'
mean_std_features <- grep("-(mean|std)\\(\\)", features$V2)
data_x <- data_x[, mean_std_features]

# Label the columns appropriately using the features data
colnames(data_x) <- features[mean_std_features, 2]


# Add descriptive activity names
data_y <- merge(data_y, activity_labels, by = "ActivityID")

# Combine subject, activity, and measurement data
full_data <- cbind(data_subject, data_y$ActivityName, data_x)
colnames(full_data)[2] <- "Activity"

library(dplyr)

tidy_data <- full_data %>%
  group_by(SubjectID, Activity) %>%
  summarise_all(funs(mean))

# Write the tidy data to a file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
