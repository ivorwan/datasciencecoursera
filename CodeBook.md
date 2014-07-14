Course Project Code Book
========================

### Code Book

This codebook explains run_analysis.R, the solution file for the Course Project for Getting and Cleaning Data class available at Coursera.
The script will generate a "tidy data" file, named output.csv


#### Steps done to generate the tidy data file

1. Download and unzip file
Script downloads the original dataset zip file to the current working directory as "zipfile.zip". It will then extract its content, also to the current working directory.


2. Reads data files
    1. Reads the X, Y and Subject files for both training and test sets
    2. Reads the features and activity lables data files
        1. renames column names for Activity Labels as "ActivityId" and "ActivityDescription"
  
3. Merge datasets
    1. First, it will merge the X datasets (xtrain, and xtest)
        1. In this step, it will also use regular expression on the features names and select only features that have "mean(" or "std("
        2. It will also apply the proper colnames() 
    2. Merges the y datasets (ytrain and ytest)
        1. applies "ActivityId" as the new column name
    3. Merges the subject datasets (subjecttrain and subjecttest)
        1. applies "SubjectId" as the new column name    
    4. Creates a mergedData dataset by combining subject, y and x
        This will create a final mergedData dataset with the following columns:
        SubjectId, ActivityId, ... (features) ...
    5. Creates a "output" dataset by merging the mergedData dataset with Activy Labels by ActivityId. This will add a new column to mergedData with the Activity Description.
        output will have the following columns:
        SubjectId, ActivityId, ... (features) ..., ActivityDescription
4. Use descriptive names
    1. Extracts the column names from the output dataset
    2. Replaces "keys" in column names with full names. For sake of readability, I've decided to use Camel Casing, since the variable names could be quite long
        1. Checks if the first character is either a "f" or "t". If so, replaces it with "Frequency" or "Time"
        2. Replaces "Acc" with "Acceleration"
        3. Replaces "Gyro" with "GyroscopeVelocity"
        4. Replaces "Mag" with "Magnitude"
        5. Replaces "mean()" with "Mean"
        6. Replaces "std()" with "StandardDeviation"
        7. Replaces "-" with "", i.e., removes "-"
        8. Finally, replaces "BodyBody" with "Body". I'm assuming it was an error when creating features.txt