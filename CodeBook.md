---
title: "CodeBook"
output: html_document
date: "2024-07-25"
---

# Codebook

## Combined Data

- **Id**: Subject ID
- **ActivityLabels**: Descriptive activity labels
- **tBodyAcc-mean()-X**: Mean value of acceleration in the X direction for the tBodyAcc feature
- **tBodyAcc-mean()-Y**: Mean value of acceleration in the Y direction for the tBodyAcc feature
- **tBodyAcc-mean()-Z**: Mean value of acceleration in the Z direction for the tBodyAcc feature
- ... (Other columns with their respective mean values for each feature)

## Activity Labels

- **ActivityLabelID**: Numerical activity label ID
- **ActivityName**: Descriptive activity name

## Features

- **id**: Feature ID
- **descri_names**: Description of the feature (e.g., "tBodyAcc-mean()-X")

## Tidy Data

- **Id**: Subject ID
- **ActivityLabels**: Descriptive activity labels
- **tBodyAcc-mean()-X**: Mean value of acceleration in the X direction for the tBodyAcc feature
- **tBodyAcc-mean()-Y**: Mean value of acceleration in the Y direction for the tBodyAcc feature
- **tBodyAcc-mean()-Z**: Mean value of acceleration in the Z direction for the tBodyAcc feature
- ... (Other columns with their respective mean values for each feature)

### Transformation Details

- The original data contained multiple measurements in a single column. This was split into separate columns based on the number of features.
- Only mean and standard deviation measurements were selected.
- Descriptive activity names were used to replace numerical activity labels.
- A tidy dataset was created with the average of each variable for each activity and each subject.
