GetData_project
===============
read the file test set

read the file test labels 
read the file with the variable names "features.txt"
 creates a new vector with the values of the variables names

asing the vector names to the name of the variables at testData

read "activity_labels file"

Create a vector with the names of the variables at testLabel

Create a vector with the V1 of the testLabel table

 Factorise the testLabelvector and adds the names from the activity_Label_names and assign them to colum1
 Create a final table with all the test Data and the Labels

Change the name of the first column of TestFinal

Read the file "test/subject_test.txt" and create a dataframe called testsubjects

 Factorise the V1 variable of testsubjects and assigns it to a new vector called testSubjectsFactor

 joints the testSubjectsFactor vector to the dataframe TestFinal

 Change the name of TestFinal first column by Subject



 Read file x_train.txt and assigns it to a table named trainData

Asign the names on the vector already created "names" to name the colums in the 

Read file y_train.txt and assigns it to a table named trainLabels   

Factorise the V1 variable in trainLabels and assigns them the names previously storaged in the vector "activity_label_names"and creates a new dataframe "colum2"

Bind the trainLabels dataframe to the trainData dataframe and creates a new table called trainFinal

change the name of colum2 to "Activity"



Read the file "train/subject_train.txt" and creates the table subjects

Factorises the V1 of the dataframe subjects and creates the vector subjectsFactor

Binds the subjectsFactor to the trainFinal dataframe and creates the final dataframe "trainData"

Changes the name of the first colum of trainData to subject


At this point, we have two dataframes: "testFina" and "trainData" with the variables correctly named and the subject added to them. The objectives 3 (Uses descriptive activity names to name the activities in the data set) and 4 (Appropriately labels the data set with descriptive variable names.) have been covered.

Now I can create a new dataframe result of merge the other two to cover the objective 1 (Merges the training and the test sets to create one data set). finalData_testandtrain 


Find the columns of the finalData_testandtrain dataframe containing the word "Mean" and create a new vector with the numbers

Find the columns of the finalData_testandtrain dataframe containing the word "std" and create a new vector with the numbers


Subseting the columns containing the Mean and std data and creating a new dataframe with them. 


Merge both dataframes to get a new dataframe with the Mean and SD of each measurement. Objective 2 (Extracts only the measurements on the mean and standard deviation for each measurement) creating a new dataframe called MeanandSDTable


Add the subjects and activity colums to my dataframe "MeanandSDTable"
first subseting the columns I need from the master dataframe and second adding the columns


Charge the package Reshape2

Re-shape the dataframe Mean_and_Finaldataframe to create a melt version using "subject and Activity" as id variables and the others (all the columnames in the MeanandSDTable) variables as measurements


Get the final dataframe applying dcast function to my melted dataframe, getting the last objective (Creates a second, independent tidy data set with the average of each variable for each activity and each subject)

Write the file containing the information of the last data frame



