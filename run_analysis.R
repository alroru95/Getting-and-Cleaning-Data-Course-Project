## Load "reshape2" package, that allows as to reshape a data frame with repeated measurements 
## in separate columns of the same record and repeated measurements in separate records.
library(reshape2)

## Download the file and put it in the data folder:
if (!file.exists("./data")) {dir.create("./data")}
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, "./data/Dataset.zip", method = "curl")

## Unzip files in the created directory
unzip("./data/Dataset.zip", exdir = "./data")

## Get the list of unzipped files
folder <- file.path("./data", "UCI HAR Dataset")
list_files <- list.files(folder, recursive = T)
list_files

## Select activity labels and features
act_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
act_labels[,2] <- as.character(act_labels[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract mean and standard deviation
msd_features <- grep(".*mean.*|.std.*", features[,2])
msd_features_names <- features[msd_features,2]
msd_features_names = gsub('-mean', 'Mean', msd_features_names)
msd_features_names = gsub('-std', 'Std', msd_features_names)
msd_features_names <- gsub('[-()]', '', msd_features_names)

## Load the datasets
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[msd_features]
train_act <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
train_sub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_sub, train_act, train)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[msd_features]
test_act <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
test_sub <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_sub, test_act, test)

## Merge datasets and add labels
merged_data <- rbind(train, test)
colnames(merged_data) <- c("subject", "activity", msd_features_names)

## Transform activities and subjects into factors
merged_data$activity <- factor(merged_data$activity, levels = act_labels[,1], labels = act_labels[,2])
merged_data$subject <- as.factor(merged_data$subject)

tidy_data <- melt(merged_data, id = c("subject", "activity"))
tidy_data_mean <- dcast(tidy_data, subject + activity ~ variable, mean)

write.table(tidy_data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
