---
title: "CodeBook"
---

## Course project of getting and cleaning data

This is an R Markdown document to describe the variables of run_analysis.R:

**Inputs:**

* activityLabels : contains activity_labels.txt
* features : contains features.txt
* xTest : contains X_test.txt
* yTest : contains Y_test.txt
* subjTest : contains subject_test.txt
* xTrain : contains X_train.txt
* yTrain : contains y_train.txt
* subjTrain : contains subject_train.txt

**Merge Inputs:**

* xTotal : union of xTest and xTrain 
* yTotal : union of yTest and yTrain
* subjTotal : union of subjTest and subjTrain
* dataSet : union xTotal, yTotal and subjTotal in columns, final data set for the
first point

**Result variables**

* meanAndStdSet : measurements on the mean and standard deviation for each 
measurement (contains column subject and column activity too).
* meanAndStdSetActiv : add activity name column, merging meanAndStdSet and 
activityLabels. After activity_id is deleted
* meltSet : meanAndStdSetActiv grouped by subject_id and activity_code
* meltSetMean : result of apply average to each measurement
* tidyData : tidy data result, meltSetMean grouped by subject_id and activity_code


