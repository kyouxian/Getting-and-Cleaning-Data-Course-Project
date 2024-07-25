# Load required libraries
library(tidyverse)

# Define a function to read data files
read_data_file <- function(path, has_col_names = FALSE) {
    read_csv(path, col_names = has_col_names)
}

# Define paths
base_path <- "~/Getting and Cleaning Data Course Project/UCI HAR Dataset/"
test_path <- paste0(base_path, "test/")
train_path <- paste0(base_path, "train/")

# Read test data
test_labels <- read_data_file(paste0(test_path, "y_test.txt"))
test_labels <- rename(test_labels, ActivityLabels = X1)

test_data <- read_data_file(paste0(test_path, "X_test.txt"))
test_data <- rename(test_data, Data = X1)

test_id <- read_data_file(paste0(test_path, "subject_test.txt"))
test_id <- rename(test_id, Id = X1)

combined_test <- bind_cols(test_id, test_labels, test_data)

# Read train data
train_labels <- read_data_file(paste0(train_path, "y_train.txt"))
train_labels <- rename(train_labels, ActivityLabels = X1)

train_data <- read_data_file(paste0(train_path, "X_train.txt"))
train_data <- rename(train_data, Data = X1)

train_id <- read_data_file(paste0(train_path, "subject_train.txt"))
train_id <- rename(train_id, Id = X1)

combined_train <- bind_cols(train_id, train_labels, train_data)

# Combine test and train data
combined_data <- bind_rows(combined_train, combined_test)

# Read additional metadata
activity_labels <- read_data_file(paste0(base_path, "activity_labels.txt"), has_col_names = TRUE)
features <- read_data_file(paste0(base_path, "features.txt"), has_col_names = TRUE)

# Separate the activity labels
activity_labels <- separate(activity_labels, X1, into = c("id", "ActivityLabel"), sep = " ")

# Separate the feature names
features <- separate(features, X1, into = c("id", "descri_names"), sep = " ")

# Select columns containing "mean()" or "std()"
mean_std_columns <- features %>%
    filter(str_detect(descri_names, "mean\\(\\)|std\\(\\)")) %>%
    pull(id)

# Select relevant columns from combined_data
selected_columns <- c("Id", "ActivityLabels", mean_std_columns)
combined_data_mean_std <- combined_data %>%
    select(one_of(selected_columns))

# Rename columns using feature descriptions
column_mapping <- setNames(features$descri_names, features$id)
names(combined_data_mean_std) <- column_mapping

# Split the 'Data' column into separate columns based on the number of features
num_features <- nrow(features)
split_data_df <- combined_data %>%
    separate_rows(Data, sep = "\\s+", convert = TRUE)

# Rename the split columns using feature descriptions
names(split_data_df) <- c(setdiff(names(split_data_df), "Data"), features$descri_names)

# Drop the original 'Data' column and concatenate the split_data_df
combined_data <- combined_data %>%
    select(-Data) %>%
    bind_cols(split_data_df)

# Filter for the mean and standard deviation columns
mean_std_columns <- features %>%
    filter(str_detect(descri_names, "mean\\(\\)|std\\(\\)")) %>%
    pull(descri_names)

combined_data_mean_std <- combined_data %>%
    select(c("Id", "ActivityLabels", mean_std_columns))

# Load the activity_labels.csv file for mapping
activity_labels_df <- read_csv("/mnt/data/activity_labels.csv")
names(activity_labels_df) <- c("ActivityLabelID", "ActivityName")

# Merge the DataFrame with the activity_labels_df
combined_data_mean_std <- combined_data_mean_std %>%
    left_join(activity_labels_df, by = c("ActivityLabels" = "ActivityLabelID")) %>%
    select(-ActivityLabelID) %>%
    rename(ActivityLabels = ActivityName)

# Calculate the mean of each variable for each activity and subject
tidy_data_df <- combined_data_mean_std %>%
    group_by(Id, ActivityLabels) %>%
    summarize(across(everything(), mean)) %>%
    ungroup()

# Display results
head(combined_data_mean_std)
head(tidy_data_df)