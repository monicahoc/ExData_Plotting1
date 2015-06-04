# Exploratory Data Analysis (Coursera) class project 1
# June 2015
# 
# This script does the following (in acordance to "Exploratory Data Analysis (Coursera)" class project 1):
#         
#         1. Construct a plot and save it to a PGN file with a widthof 480 pixels and hight 480 pixels
#         2. The plots to that need to be constructed can be seen at the assigment (https://class.coursera.org/exdata-015/human_grading/view/courses/973509/assessments/3/submissions)
#         3. This file creates the first plot
# -------------------------------------------------------------------------------------
# In order to get the data the following steps are taken:
#         
#       a) Download data
#       b) Unzip data
#       c) Read all data into tables
#
# a) Download data
#    Set working directory and load the libraries that are needed in the project

setwd("C:/Users/Monica/Desktop/Analytics Software/R project/R_Working_Directory/Coursera/4 Exploratory Data Analysis/Project1")

library(lubridate)

datadir <- getwd()

#    Check if a folder where to store the data exist (called "data"), if not create one

if(!file.exists("data")){
        dir.create("data")
}

#    Download file (zip file) that goes to a folder called "projectdata.zip"

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/projectdata.zip", mode="wb")

dateDownloaded <- date()        #Get download date

# b) Unzip data in projectdata.zip folder

setwd("./data")                 # Change workingdirectory to "data"

unzip("projectdata.zip")

list.files()    

# c) Read all data into a table and get the dimensions of thise table

energyData <- read.table("household_power_consumption.txt", sep = ";", 
    header = TRUE, stringsAsFactors=FALSE, na.strings="?")

# Note: the columns are separated by a semicolon(;), the missing values are coded as a question mark (?),
# I don't want the strings to be fators and the table comes with column names already
dim(energyData)
names(energyData)

# Using the lubridate library the dates in the "Date" column of the table are identify and parse
# a new column is added to the original table called "Date1"

energyData$Date1 <- dmy(energyData$Date)

#This are the boundary dates needed parse with lubridate library
beginning <- ymd("2007-02-01")
end <- ymd("2007-02-02")

# Subseting the data table to only get the rows between Feb 1 and Feb 2, 2007

subsetEnergyData <- energyData[energyData$Date1 >= beginning & energyData$Date1 <= end,]

# Create a histogram (first plot requested) as a PNG file  with a width of 480 pixels and a height of 480 pixels
# The file is called "plot1"
# Note: Remember always to close the file device

png(file ="plot1.png", width = 480, height = 480, units = "px")
hist(subsetEnergyData$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off() ## Close the PNG file device