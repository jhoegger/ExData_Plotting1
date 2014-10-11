##    ------------  Plot 1 ---------  ##


library(dplyr)

#Set the filename for the data file
filename <- "household_power_consumption.txt"

##only read in the first 100,000 rows of data
data <-read.csv(filename, sep = ";", header = TRUE, nrows=100000)
DT <- tbl_df(data)

##change the date to by of type Date
DT$Date <-  as.Date(DT$Date, "%d/%m/%Y")

##filter to just 2/1/2007 & 2/2/2007
DTFeb <-filter(DT, Date == as.Date("2/1/2007", "%m/%d/%Y") | Date == as.Date("2/2/2007", "%m/%d/%Y"))
DTFeb$Global_active_power <- as(DTFeb$Global_active_power, "character")

##change DTFeb$Global_active_power to be numeric
DTFeb$Global_active_power <- as(DTFeb$Global_active_power, "numeric")

#Create a.png file and set the dimensions 
png(file="plot1.png", width=480, height=480, units="px")

#plot the histogram
with(DTFeb,hist(Global_active_power, col="red", main="Global Active Power", ylim=range(0,1200),xlab="Global Active Power (kilowatts)"))

#close the .png file
dev.off()
