setwd("/Users//SITB/Desktop/getting and cleaning data/UCI HAR Dataset/")

# read test set
testData<- read.table (file="test/X_test.txt")
# read test labels 
testLabel<- read.table (file="test/y_test.txt")
# read the file with the variable names
dataNames<-read.table(file="features.txt")
# creates a new vector with the values of the variables names
names<- dataNames$V2
# asing the vector names to the name of the variables at testData
colnames(testData)<- names
# read "activity_labels file"
activity_labels<-read.table(file="activity_labels.txt")
head(activity_labels)
# Creates a vector with the names of the variables at testLabel
activity_label_names <- activity_labels$V2
# Creates a vector with the V1 of the testLabel table
testLabelvector<- (testLabel$V1)
# Factorises the testLabelvector and adds the names from the activity_Label_names and assign them to colum1
colum1<- factor (testLabelvector, labels=activity_label_names)
# Creates a final table with all the test Data and the Labels
TestFinal<-cbind(colum1,testData)
head(TestFinal,n=3)
# Change the name of the first column of TestFinal
colnames(TestFinal)[1]<- "Activity"

#Read the file "test/subject_test.txt" and creates a dataframe called testsubjects
testsubjects <- read.table(file="test/subject_test.txt")
# Factorises the V1 variable of testsubjects and assigns it to a new vector called testSubjectsFactor
testSubjectsFactor <- factor (testsubjects$V1)
str(testSubjectsFactor)
# joints the testSubjectsFactor vector to the dataframe TestFinal
TestFinal<-cbind (testSubjectsFactor, TestFinal)
head (TestFinal,n=1)
# Changes the name of TestFinal first column
colnames(TestFinal)[1]<- "Subject"
colnames(TestFinal)

# Read file x_train.txt and assigns it to a table named trainData
trainData<- read.table(file="train/X_train.txt")
# Asign the names on the vector already created "names" to name the colums in the dataframe trainData
colnames(trainData)<- names
head (trainData,n=3)
# Read file y_train.txt and assigns it to a table named trainLabels   
trainLabels<- read.table(file="train//y_train.txt")
head(trainLabels, n=3)
# Factorises the V1 variable in trainLabels and assigns them the names previously storaged in the vector "activity_label_names"and creates a new dataframe "colum2"
colum2<-factor(x=trainLabels$V1,labels=activity_label_names)
# Binds the trainLabels dataframe to the trainData dataframe and creates a new table called trainFinal
trainFinal<-cbind(colum2,trainData)
# change the name of colum2 to "Activity"
colnames(trainFinal)[1]<- "Activity"
head(trainFinal,n=3)

# Read the file "train/subject_train.txt" and creates the table subjects
subjects <- read.table(file="train//subject_train.txt")
head (subjects, n=3)
# Factorises the V1 of the dataframe subjects and creates the vector subjectsFactor
subjectsFactor<-factor(x=subjects$V1)
str(subjectsFactor)
# Binds the subjectsFactor to the trainFinal dataframe and creates the final dataframe "trainData"
trainData<-cbind(subjectsFactor,trainFinal)
head(trainData,n=1)
# Changes the name of the first colum of trainData
colnames(trainData)[1]<- "Subject"
head(trainData,n=1)

# At this point, we have two dataframes: "testFina" and "trainData" with the variables correctly 
  # named and the subject added to them. The objectives 3 (Uses descriptive activity names to name the activities in the data set)
  # and 4 (Appropriately labels the data set with descriptive variable names.) have been covered.

# Now I can create a new dataframe result of merge the other two to cover the objective 1 (Merges the training and the test sets to create one data set)

finalData_testandtrain <- rbind(TestFinal, trainData)
head(finalData_testandtrain, n=2)

# Find the columns of the finalData_testandtrain dataframe containing the word "Mean" and create a new vector with the numbers
MeanColumns<- grep(pattern="Mean",colnames(finalData_testandtrain))
# Find the columns of the finalData_testandtrain dataframe containing the word "std" and create a new vector with the numbers
StdColumns<- grep(pattern="std",colnames(finalData_testandtrain))

# Subseting the columns containing the Mean and std data and creating a new dataframe with them. 
MeanTable<- subset.data.frame(finalData_testandtrain, select =c(MeanColumns))
strTable <- subset.data.frame(finalData_testandtrain, select= c(StdColumns))

# Merge both dataframes to get a new dataframe with the Mean and SD of each measurement. Objective 2 (Extracts only the measurements on the mean and standard deviation for each measurement)
# creating a new dataframe called MeanandSDTable
MeanandSDTable<- cbind(MeanTable,strTable)
head (MeanandSDTable, n=2)

# Add the subjects and activity colums to my dataframe "MeanandSDTable"
startcolumns<-finalData_testandtrain[,1:2] # subset the columns I need from the master dataframe
Mean_and_SD_Final_Dataframe<- cbind(startcolumns,MeanandSDTable) # add the columns


# Charge the package Reshape2
library(reshape2)

# Re-shape the dataframe Mean_and_Finaldataframe to create a
# melt version using "subject and Activity" as id variables and the others (all the columnames in the MeanandSDTable)
# variables as measurements

Mean_and_Final_Dataframe_Mealt <- melt(Mean_and_SD_Final_Dataframe, id=c("Subject","Activity"), measure.vars= colnames(MeanandSDTable))
head(Mean_and_Final_Dataframe_Mealt)

# Get the final dataframe applying dcast function to my melted dataframe, getting the last objective
# (Creates a second, independent tidy data set with the average of each variable for each activity and each subject)

lastDataFrame<- dcast (Mean_and_Final_Dataframe_Mealt,Subject + Activity ~ variable, mean)
head(lastDataFrame, n=3)

write.table(lastDataFrame,"Lastdataframe.txt")

