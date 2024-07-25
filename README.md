---
title: "README"
output: html_document
date: "2024-07-25"
---

# Data Cleaning and Tidy Data Generation

## Introduction

This repository contains the scripts and data used for cleaning and preparing the Human Activity Recognition Using Smartphones dataset for analysis. The goal was to create a tidy dataset that can be used for further analysis.

## Data Description

The Human Activity Recognition Using Smartphones dataset contains data collected from the accelerometers of the Samsung Galaxy S smartphone. The dataset consists of training and test sets, along with activity labels and feature descriptions.

## Analysis Scripts

- **run_analysis.R**: This script performs the data cleaning and tidying process. It merges the training and test sets, extracts mean and standard deviation measurements, replaces numerical activity labels with descriptive names, and creates a tidy dataset with the average of each variable for each activity and subject.

## Data Files

- **combined_data.csv**: The combined dataset containing both training and test sets.
- **features.csv**: The feature descriptions.
- **activity_labels.csv**: The mapping between numerical activity labels and descriptive names.
- **tidy_data.csv**: The tidy dataset with the average of each variable for each activity and subject.

## Usage

To run the analysis, execute the following command in an R environment:

```R
source('run_analysis.R')
