#####################################################################################
# downloads and unzip files
#####################################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl, destfile = "./zipfile.zip", mode="wb")

unzip("./zipfile.zip")


#####################################################################################
# reads files
#####################################################################################

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
# dim(xtrain)
# 7352 x 561

ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
# dim(ytrain)
# 7352 x 1

subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# dim(subjecttrain)
# 7352 x 1


xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
# dim(xtest)
# 2947 x 561

ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
# dim(ytest)
# 2947 x 1

subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# dim(subjecttest)
# 2947 x 1


features <- read.table("./UCI HAR Dataset/features.txt")
# dim(features)
# 561 x 2

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityLabels$V2 = factor(c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying"))
# dim(activityLabels)
# 6 x 2


grep("(mean|std)", features)


#####################################################################################
# Merging datasets
#####################################################################################

# combines xtrain and xtest
mergedx <- rbind(xtrain, xtest)

# selects only measurements with mean and avg, by applying regex

mergedx <- mergedx[,grep("mean\\(|std\\(", features$V2)]
mergedsubject <- rbind(subjecttrain, subjecttest)
mergedy <- rbind(ytrain, ytest)

mergedData <- cbind(mergedsubject, mergedy, mergedx)

featureDescriptiveNames <- c("SubjectId",
                             "ActivityId",
                             "BodyAccelerationMeanTimeOnX",
                             "BodyAccelerationMeanTimeOnY",
                             "BodyAccelerationMeanTimeOnZ",
                             "BodyAccelerationStandardDeviationTimeOnX",
                             "BodyAccelerationStandardDeviationTimeOnY",
                             "BodyAccelerationStandardDeviationTimeOnZ",
                             "GravityAccelerationMeanTimeOnX",
                             "GravityAccelerationMeanTimeOnY",
                             "GravityAccelerationMeanTimeOnZ",
                             "GravityAccelerationStandardDeviationTimeOnX",
                             "GravityAccelerationStandardDeviationTimeOnY",
                             "GravityAccelerationStandardDeviationTimeOnZ",
                             "BodyAccelerationJerkMeanTimeOnX",
                             "BodyAccelerationJerkMeanTimeOnY",
                             "BodyAccelerationJerkMeanTimeOnZ",
                             "BodyAccelerationJerkStandardDeviationTimeOnX",
                             "BodyAccelerationJerkStandardDeviationTimeOnY",
                             "BodyAccelerationJerkStandardDeviationTimeOnZ",
                             "BodyGyroscopeVelocityMeanTimeOnX",
                             "BodyGyroscopeVelocityMeanTimeOnY",
                             "BodyGyroscopeVelocityMeanTimeOnZ",
                             "BodyGyroscopeVelocityStandardDeviationTimeOnX",
                             "BodyGyroscopeVelocityStandardDeviationTimeOnY",
                             "BodyGyroscopeVelocityStandardDeviationTimeOnZ",
                             "BodyGyroscopeVelocityJerkMeanTimeOnX",
                             "BodyGyroscopeVelocityJerkMeanTimeOnY",
                             "BodyGyroscopeVelocityJerkMeanTimeOnZ",
                             "BodyGyroscopeVelocityStandardDeviationJerkTimeOnX",
                             "BodyGyroscopeVelocityStandardDeviationJerkTimeOnY",
                             "BodyGyroscopeVelocityStandardDeviationJerkTimeOnZ",
                             "BodyAccelerationMagnitudeMeanTime",
                             "BodyAccelerationMagnitudeStandardDeviationTime",
                             "GravityAccelerationMagnitudeMeanTime",
                             "GravityAccelerationMagnitudeStandardDeviationTime",
                             "BodyAccelerationMagnitudeJerkMeanTime",
                             "BodyAccelerationMagnitudeJerkStandardDeviationTime",
                             "BodyGyroscopeVelocityMagnitudeMeanTime",
                             "BodyGyroscopeVelocityMagnitudeStandardDeviationTime",
                             "BodyGyroscopeVelocityMagnitudeJerkMeanTime",
                             "BodyGyroscopeVelocityMagnitudeJerkStandardDeviationTime",
                             "BodyAccelerationMeanFrequencyOnX",
                             "BodyAccelerationMeanFrequencyOnY",
                             "BodyAccelerationMeanFrequencyOnZ",
                             "BodyAccelerationStandardDeviationFrequencyOnX",
                             "BodyAccelerationStandardDeviationFrequencyOnY",
                             "BodyAccelerationStandardDeviationFrequencyOnZ",
                             "BodyAccelerationJerkMeanFrequencyOnX",
                             "BodyAccelerationJerkMeanFrequencyOnY",
                             "BodyAccelerationJerkMeanFrequencyOnZ",
                             "BodyAccelerationJerkStandardDeviationFrequencyOnX",
                             "BodyAccelerationJerkStandardDeviationFrequencyOnY",
                             "BodyAccelerationJerkStandardDeviationFrequencyOnZ",
                             "BodyGyroscopeVelocityMeanFrequencyOnX",
                             "BodyGyroscopeVelocityMeanFrequencyOnY",
                             "BodyGyroscopeVelocityMeanFrequencyOnZ",
                             "BodyGyroscopeVelocityStandardDeviationFrequencyOnX",
                             "BodyGyroscopeVelocityStandardDeviationFrequencyOnY",
                             "BodyGyroscopeVelocityStandardDeviationFrequencyOnZ",
                             "BodyAccelerationMagnitudeMeanFrequency",
                             "BodyAccelerationMagnitudeStandardDeviationFrequency",
                             "BodyAccelerationMagnitudeJerkMeanFrequency",
                             "BodyAccelerationMagnitudeJerkStandardDeviationFrequency",
                             "BodyGyroscopeVelocityMagnitudeMeanFrequency",
                             "BodyGyroscopeVelocityMagnitudeStandardDeviationFrequency",
                             "BodyGyroscopeVelocityMagnitudeJerkMeanFrequency",
                             "BodyGyroscopeVelocityMagnitudeJerkStandardDeviationFrequency")
                                 
colnames(mergedData) <- featureDescriptiveNames


activityLabels

mergedData <- merge(mergedData, activitylabels, by.x = "ActivityId", by.y = "V2", all=FALSE)


