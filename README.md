# Getting-and-Cleaning-Data-Course-Project
This is the solution for the course project for the Getting and Cleaning Data Coursera course, organised by the JHU. This R script (run_analysis.R) is supposed to do the following steps:
1) If necessary, downloads the "UCI HAR Dataset" into the working directory.
2) Loads files concerning "activity" and "feature" info.
3) Loads both training and test datasets, extracting information referred to the mean and standard deviation for each measurement.
4) Loads the activity and subject columns for each dataset (training and test), and merges those columns with the dataset.
5) Merges these datasets.
6) Transforms activity and subject columns into factors.
7) Creates a final dataset that consists of the mean value of each variable for each subject-activity pair.

The result of these steps is shown in tidy.txt
