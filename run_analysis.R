# Load in the data from the downloaded zip file

X_train <- read.table('UCI HAR Dataset/train/X_train.txt' )
X_test <- read.table('UCI HAR Dataset/test/X_test.txt')

y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')

# Read in column names from 'features.txt', then reformat them into acceptable column names. 

features <- read.table('UCI HAR Dataset/features.txt')
names <- make.names(features$V2)

activity <- read.table('UCI HAR Dataset/activity_labels.txt')

# Step 1: merge the train and test data set into one data set with proper column names

dataX <- rbind(X_train, X_test)
names(data) <- names

datay <- rbind(y_train, y_test)

# Step 2: extract the measures on the mean and standard deviation of the measurements

extractcols <- grep('*.std.*|*.mean.*', names)

subdata <- dataX[, extractcols]

