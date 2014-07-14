Course Project Code Book
========================

### Code Book

This codebook explains run_analysis.R, the solution file for the Course Project for Getting and Cleaning Data class available at Coursera.
The script will generate a "tidy data" file, named output.csv


#### Steps in this script to generate the tidy data file

1. Download and unzip file
    1. Script downloads the original dataset zip file to the current working directory as "zipfile.zip". It will then extract its content, also to the current working directory.


2. Reads data files
    1. Reads the X, Y and Subject files for both training and test sets
        1. stores these datasets in xtrain, xtest, ytrain, ytest and subjecttrain, subjecttest
    2. Reads feature data file
    3. Reads activity data file
        1. stores in ActivityLAbels
        2. renames column names for ActivityLAbels as "ActivityId" and "ActivityDescription"
  
3. Merge datasets
    1. First, it will merge the X datasets (xtrain, and xtest) into "mergedx"
        1. In this step, it will also use regular expression on the features names and select only features that have "mean(" or "std("
        2. It will also apply the proper colnames() 
    2. Merges the y datasets (ytrain and ytest) into "mergedy"
        1. applies "ActivityId" as the new column name
    3. Merges the subject datasets (subjecttrain and subjecttest) into "mergedsubject"
        1. applies "SubjectId" as the new column name    
    4. Creates a "mergedData"" dataset by combining "mergedsubject", "mergedy" and "mergedx"
        mergedData will have the following columns:
        SubjectId, ActivityId, ... (features) ...
    5. Creates a "output" dataset by merging "mergedData"" dataset with "ActivyLabels"" by ActivityId. This will add a new column to mergedData with the more meaningful ActivityDescription.
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
5. Generates a csv file from "output" dataset        