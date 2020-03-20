# Load in the data from the downloaded zip file

X_train <- read.table('UCI HAR Dataset/train/X_train.txt' )
X_test <- read.table('UCI HAR Dataset/test/X_test.txt')

y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')

# Read in column names from 'features.txt', then reformat them into acceptable column names. 

features <- read.table('UCI HAR Dataset/features.txt')
names <- make.names(features$V2)

# Read in subject file

subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
allsubject <- rbind(subject_train, subject_test)

# Step 1: merge the train and test data set into one data set with proper column names

dataX <- rbind(X_train, X_test)
#names(dataX) <- names

datay <- rbind(y_train, y_test)

# Step 2: extract the measures on the mean and standard deviation of the measurements

extractcols <- grep('*.std.*|*.mean.*', names)

subdata <- dataX[, extractcols]

# Step 3: Uses descriptive activity names to name the activities in the data set

activity <- read.table('UCI HAR Dataset/activity_labels.txt')

datay['Activity'] <- sapply(datay$V1, function(v) activity[v, 'V2'])

# Step 4: Appropriately labels the data set with descriptive variable names.

extractnames <- grep('*.std.*|*.mean.*', names, value = TRUE)
colnames(subdata) <- extractnames
colnames(allsubject) <- 'subject'

subdata.activity <- cbind(subdata, activity = datay$Activity)
subdata.activity <- cbind(subdata.activity, allsubject)

# step 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

library(data.table)

DT <- data.table(subdata.activity)
setkey(DT, activity, subject)
meanDF <- DT[, lapply(.SD, mean), by=.(activity,subject)]

