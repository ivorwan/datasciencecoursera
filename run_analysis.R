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
colnames(activityLabels) <- c("ActivityId", "ActivityDescription")
# dim(activityLabels)
# 6 x 2


#####################################################################################
# Merging datasets
#####################################################################################

# combines xtrain and xtest
mergedx <- rbind(xtrain, xtest)

# selects only measurements with mean and avg, by applying regex

mergedx <- mergedx[,grep("mean\\(|std\\(", features$V2)]
colnames(mergedx) <- grep("mean\\(|std\\(", features$V2)
colnames(mergedx) <- features[grep("mean\\(|std\\(", features$V2),2]

mergedsubject <- rbind(subjecttrain, subjecttest)
colnames(mergedsubject) <- "SubjectId"

mergedy <- rbind(ytrain, ytest)
colnames(mergedy) <- "ActivityId"

mergedData <- cbind(mergedsubject, mergedy, mergedx)

output <- merge(mergedData, activityLabels, by.x = "ActivityId", by.y = "ActivityId", all=FALSE)

#####################################################################################
# Descriptive Names
#####################################################################################

featureDescriptiveNames <- names(output)



featureDescriptiveNames <- sapply(featureDescriptiveNames, function(x) if(substr(x, 1, 1) == "f") { sub("f", "Frequency", x)} else {x})
featureDescriptiveNames <- sapply(featureDescriptiveNames, function(x) if(substr(x, 1, 1) == "t") { sub("t", "Time", x)} else {x})

featureDescriptiveNames <- sub("Acc", "Acceleration", featureDescriptiveNames)
featureDescriptiveNames <- sub("Gyro", "GyroscopeVelocity", featureDescriptiveNames)

featureDescriptiveNames <- sub("Mag", "Magnitude", featureDescriptiveNames)



featureDescriptiveNames <- sub("mean\\(\\)", "Mean", featureDescriptiveNames)
featureDescriptiveNames <- sub("std\\(\\)", "StandardDeviation", featureDescriptiveNames)

featureDescriptiveNames <- sub("-", "", featureDescriptiveNames)
featureDescriptiveNames <- sub("BodyBody", "Body", featureDescriptiveNames)


colnames(output) <- featureDescriptiveNames

#####################################################################################
# Generates File
#####################################################################################


write.table(output, file="output.csv", sep=",", row.names=FALSE, col.names=TRUE)
