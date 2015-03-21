#### CodeBook.md file for run_analysis.R script.
#### This is for the Coursera.org course assignment in "Getting and Cleaning Data"


### Variable used

X_test		Contains the X_test.txt data
X_train		Contains the X_train.txt data
Y_test		Contains the y_test.txt data
Y_train		Contains the y_train.txt data
subject_test	Contains the subject_test.txt data
subject_train	Contains the subject_traing.txt data

Lines 23 - 25
Combine the X data and the Y data sets together.

Line 27
Combine the subject datasets together.

--------------------

### Variables used
featues		Contains the features.txt data
namevect	Vector containing the names of the features
meanlist	Vector containing the list of features that have the name -mean() and not thimgs like gravityMean

stdlist		Vector containing the list of features that have the -std() and similar to meanlist
mands_dataframe	This is a dataframe containing the means and std's

Lines 49-63
In this section of the code the dataset is subsetted only have the -mean() and -std() variables. The first two columns is the Subject number between 1 to 30 and the second column is between 1 to 6 that designates the Activities performed.

--------------------
Lines 67 -68
Transformation of the Activity numbers to the corresponding character string activity.

--------------------
### Variables used

sorted_result	The data frame of mands_dataframe is arranged in Subject then Activity order.
xmelt		The data frame is transformed into a skinny long dataset
output		The final returned output

Line 80
dcast is run to provide the mean of all the variables



