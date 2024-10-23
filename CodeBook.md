# Code Book for UCI HAR Data Cleaning

## Variables
- `SubjectID`: Identifier for each subject in the study (1-30).
- `Activity`: The name of the activity being performed (e.g., "WALKING", "SITTING").
- Mean and standard deviation measurements: Variables calculated from the accelerometer and gyroscope data.

## Transformations
- Combined the training and test datasets.
- Extracted only the mean and standard deviation variables.
- Added descriptive activity names from the `activity_labels.txt` file.
- Created a tidy dataset with the average of each variable for each activity and subject.
