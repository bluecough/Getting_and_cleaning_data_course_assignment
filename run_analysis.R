## run_analysis.R
## This script performs the following:
## 1. Merges 

## Load plyr library for sorting purposes
library(plyr)
library(reshape2)


run_analysis <- function() {

    ## 1. Merge files
    ## Load files
    
    X_test <- read.table("test/X_test.txt")
    X_train <- read.table("train/X_train.txt")
    Y_test <- read.table("test/y_test.txt")
    Y_train <- read.table("train/y_train.txt")
    
    subject_test <- read.table("test/subject_test.txt")
    subject_train <- read.table("train/subject_train.txt")
    
    ## Perform the Merging
    XTotal <- rbind(X_test, X_train)
    YTotal <- rbind(Y_test, Y_train)
    
    SubjectTotal <- rbind(subject_test, subject_train)
    
    ## First add SubjectTotals with YTotals before XTotals
    SubjectTotal <- cbind(SubjectTotal, YTotal)
    SubjectTotal <- cbind(SubjectTotal, XTotal)
        
    ### 2. Extract only the measurements on the mean and Std Dev for each measurement
    ## Load the features.txt file
    
    ## Load names
    features <- read.table("features.txt")
    namevect <- as.character(features[,2])
    namevect <- append(c("Subject", "Activity"), namevect)

    ## Find all the columns that either end with -mean() or -std() and save 
    ## those to a vector
    meanlist <- grep("*.-mean\\(\\).?", features[,2])
    stdlist <- grep("*.-std\\(\\).?", features[,2])
    
    ## Shift each element by 2 because we added Subject and Activity in the
    ## first two columns
    
    meanlist <- meanlist+2
    stdlist <- stdlist+2
    mean_and_std_list <- c(1,2)
    mean_and_std_list <- append(mean_and_std_list, meanlist)
    mean_and_std_list <- append(mean_and_std_list, stdlist)
    mean_and_std_list <- sort(mean_and_std_list)
    
    length <- nrow(SubjectTotal)
    ## Create data.frame with only mean and std columns.
    mands_dataframe <- data.frame(row.names=1:length)
    listofnames <- c()
    for (i in mean_and_std_list) {
        mands_dataframe <- cbind(mands_dataframe, SubjectTotal[,i])
        listofnames <- append(listofnames, namevect[i])
    }
    
    ## 3. Activity Names mapping to column2 which is called Activity.
    
    mands_dataframe[,2] <- as.character(mands_dataframe[,2])
    mands_dataframe[,2] <- mapvalues(mands_dataframe[,2], c(1,2,3,4,5,6), c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
    
    ## 4. Appropriately label the data set with descriptive variable names.
    colnames(mands_dataframe) <- listofnames
   
    
    ## DDPLYR
    ## 
    # Use melt to make a long skinny table
    # dcast to get final results
    sorted_result <- arrange(mands_dataframe, Subject, Activity)
    xmelt <- melt(sorted_result, id=c("Subject", "Activity"))
    output <- dcast(xmelt, Subject + Activity ~ variable, mean)
    
}
