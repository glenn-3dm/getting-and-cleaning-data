READ ME

The run_analysis.R script reads in the following 8 .txt files and compile them into a tidy data set showing the averages for each activity for each subject for the observations (or features) containing “mean” or “std”:
1. activity_labels.txt
2. features.txt
3. X_test.txt
4. y_test.txt
5. subject_text.txt
6. X_train.txt
7. y_train.txt
8. subject_train.txt

The following variables were used to achieve stated objective:
- test.activities/train.activities : these are the imported raw datasets containing the activity numbers (1-6).
o These data frames were then re-assigned using a right_join function with the activity.names data frame to convert the numeric activity denotation to the corresponding activity name.
- activity.names : this data frame is the imported raw file showing the activity number (1-6) and the corresponding activity names.
- observation.names : this data frame is the imported raw file showing the 561 different observations (or features) for each subject measurements.
- test.subject/train.subject : these are the imported raw files showing the subject id numbers for each subject being measured.
- test.data/train.data : these are the raw datasets for each subject group containing the measurements for each subject multiple times over each activity and each observation.  
o The colnames() function was used to convert the observation.names data set into the column names for each 561 observations over the raw measured dataset.
- test.mean.std/train.mean.std : these are subsets of the original .data files which select out only the measurements concerned with mean and standard deviation as directed in the project assignment directions. 
- test.final/train.final : these datasets are the combination of the .subject, .activities, and .mean.std files to create a labeled data set showing the subject number, the activity names, and the labeled measured raw data from the observations denoting mean or standard deviation.
- test.summary/train.summary : these datasets show the average values for each observation grouped by subject id number and activity name.
- final.summary : the test.summary and train.summary datasets were combined into one final tidy dataset showing the average values for each observation grouped by subject id number and activity name.
