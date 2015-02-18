This repository contains the files for my course project for the Coursera class "Getting and Cleaning Data". There are two files in addition to this README:

run_analysis.R  
CodeBook.md

run_analysis.R is an R script that will output the file "mean_values.txt", which shows the average value of certain variables for each activity/subject combination from the original data sets.

CodeBook.md contains a list of all the variable names used in "mean_values.txt", and it explains the meaning of each variable name.

Instructions for running this code:
* If you don't already have the data files downloaded for this project, download them here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the folder.
* Open R and set the working directory to the folder containing the data files.
* Run the script "run_analysis.R" (this will take a few minutes on slower computers)
* This will create a file "mean_values.txt", which should be the same as what I submitted in part 1 of the assignment.
