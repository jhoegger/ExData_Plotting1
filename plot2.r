## Plot2 ##

library(utils)
library(dplyr)
setwd("C:/Projects/Coursera-DS/4.Explore/Project")
if (!file.exists("PowerData.zip")) { 
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
        destfile="PowerData.zip") 

}

filename <- "household_power_consumption.txt"
##only read in the first 100,000 rows of data
data <- read.table(unz("PowerData.zip", filename), header=T, quote="\"", sep=";", na.strings="?", nrows=100000) 

## Convert the date to a date object 
data$Date <- as.Date(data$Date, format="%d/%m/%Y") 

## Only get Feb1 and Feb2 data
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"), ] 
 
## Create a new Date/Time combined column
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S") 

## Create plot and save a png file

plotFile <- "C:/Projects/Coursera-DS/4.Explore/Project/plot2.png"
png(filename = plotFile, width = 480, height = 480, units = "px", pointsize = 12,  bg = "white", res = NA, family = "", restoreConsole = TRUE)
##windows()
plot(y=data$Global_active_power, x=data$DateTime, ylab="Global Active Power (killowatts)", xlab="",type="l") 
dev.off()
