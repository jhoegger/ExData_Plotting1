##    ------------  Plot 3 ---------  ##



library(utils)
library(dplyr)

if (!file.exists("PowerData.zip")) { 
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
        destfile="PowerData.zip") 
}

#Set the filename for the data file
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

#A .png file with the desired dimensions is opened
png(file="plot3.png", width=480, height=480, units="px")

#The desired plot is plotted
with(data, {plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", 
                 ylab="Energy sub metering")
            lines(DateTime, Sub_metering_2, col="red")
            lines(DateTime, Sub_metering_3, col="blue")})

#Add Legend to the plot
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1)) 

#close the .png file
dev.off()
