##    ------------  Plot 4 ---------  ##


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

#Create a.png file and set the dimensions 
png(file="plot4.png", width=480, height=480, units="px")

#make a 2 by 2 grid for the plots
par(mfrow = c(2,2))

#The desired plots are plotted
with(data, {plot(DateTime, Global_active_power, col="black", type="l", xlab="", 
                 ylab="Global Active Power")
            plot(DateTime, Voltage, col="black", type="l", xlab="datetime", 
                 ylab="Voltage")
            plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", 
                 ylab="Energy sub metering")
            lines(DateTime, Sub_metering_2, col="red")
            lines(DateTime, Sub_metering_3, col="blue")
            legend("topright", col=c("black", "red", "blue"), lty=1, bty="n", cex=0.9,
                   legend=names(data)[7:9])
            plot(DateTime, Global_reactive_power, col="black", type="l", xlab="datetime")})

#close the .png file
dev.off()
