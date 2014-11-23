## Course project of Getting and Cleanning Data (3rd Week)

## 1. Merges the training and the test sets to create one data set.

##      Read activity labels
        activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        colnames(activityLabels) <- c("activity_id","activity_code")
##      Read features 
        features <- read.table("./UCI HAR Dataset/features.txt")

##      Read Test Set
        xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
        yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
        subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##      Read Train Set
        xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
        yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
        subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##      The training and test files of the same type  are joined before starting 
##      work. We always add training files to test files, in the same order:
##      type-X files contain features values
        xTotal <- rbind(xTest,xTrain) 
        colnames(xTotal) <- features$V2 # 561 columns
##      type-Y files contain activity id (from 1 to 6)
        yTotal <- rbind(yTest,yTrain)
        colnames(yTotal) <-"activity_id"
##      subject files contain subject id (from 1 to 30)
        subjTotal <- rbind( subjTest, subjTrain)
        colnames(subjTotal) <-"subject_id"
 
        dataSet <- cbind(xTotal,yTotal,subjTotal)

        
##      2. Extracts only the measurements on the mean and standard deviation for
##      each measurement.
##      We select the columns whose names contain "mean" or "std" and the two
##      last columns (activity_id and subject_id)
        meanAndStdSet <- dataSet[,c(grep("mean|std",features$V2),
                                    ncol(dataSet)-1,ncol(dataSet))]

        
##      3. Uses descriptive activity names to name the activities in the data set.
##      Merge  activityLabels and meanAndStdSet  by  activity_id   
        meanAndStdSetActiv <- merge (meanAndStdSet, activityLabels, 
                                     by.x="activity_id", by.y="activity_id", all=TRUE)

##      4. Appropriately labels the data set with descriptive variable names.
##      Data.frame already has column names
        names(meanAndStdSetActiv)
        
        
##      5. From the data set in step 4, creates a second, independent tidy data 
##      set with the average of each variable for each activity and each subject.
##      First delete 'activity_id' column
        meanAndStdSetActiv <- meanAndStdSetActiv[,(2:ncol(meanAndStdSetActiv))]
##      create groups by subject_id and activity_code
        library(reshape2)
        meltSet <- melt(meanAndStdSetActiv,id = c("subject_id","activity_code"))
##      Apply mean for each variable by subject_id and activity_code
        meltSetMean <- dcast(meltSet,subject_id + activity_code ~ variable,mean)
        tidyData <- melt(meltSetMean,id = c("subject_id","activity_code"))
##      Write .txt file
        write.table(tidyData,"./UCI HAR Dataset/tidyDataSet.txt", row.names=FALSE)