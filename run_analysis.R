library(dplyr)

"Download file"
myURL = paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",sep = "")

dir = "./zippedfile.zip"
download.file(myURL, dir, mode="wb")

"Unzip file"
unzip("./zippedfile.zip",)

"Read in file"
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt",sep = "", header = FALSE)
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt",sep = "", header = FALSE)

"Add in headings from features file"
Headings <- read.table("./UCI HAR Dataset/features.txt",sep = "", header = FALSE)
colnames(XTest) <- Headings$V2
colnames(XTrain) <- Headings$V2
XData <- rbind(XTrain,XTest) 

"Get all the headings with mean/std as the mean and standard variation of each measurement was required"
ColList <- grep("mean|std]",Headings$V2,value = FALSE)
XDataEd <- select(XData,ColList)
"Remove meanFreq"
NewHeadings <- colnames(XDataEd)
NewColList <- grep("meanFreq",NewHeadings,value = FALSE,invert = TRUE)
XFinal <- select(XDataEd,NewColList)
"Calculate Average"
XAvg <- colMeans(XFinal, na.rm = FALSE)
X <- data.frame(XAvg)
"Done"
