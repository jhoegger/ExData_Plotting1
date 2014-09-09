## Plot2 ##



library(dplyr)
setwd("C:/Projects/Coursera-DS/4.Explore/Project")
filename <- "household_power_consumption.txt"
##only read in the first 100,000 rows of data
data <-read.csv(filename, sep = ";", header = TRUE, nrows=100000)
DT <- tbl_df(data)
##filter to just 2/1/2007 & 2/2/2007
DTFeb <-filter(DT, Date == as.Date("2/1/2007", "%m/%d/%Y") | Date == as.Date("2/2/2007", "%m/%d/%Y"))

DTFeb[DateTime] <- paste(DTFeb$Date, DTFeb$Time, Sep=" ")

##change the date to by of type Date
DT$Date <-  as.Date(DT$Date, "%d/%m/%Y")

DTFeb$Global_active_power <- as(DTFeb$Global_active_power, "character")
##change DTFeb$Global_active_power to be numeric
DTFeb$Global_active_power <- as(DTFeb$Global_active_power, "numeric")
##plot Hist
plotFile <- "C:/Projects/Coursera-DS/4.Explore/Project/plot2.png"
png(filename = plotFile, width = 480, height = 480, units = "px", pointsize = 12,  bg = "white", res = NA, family = "", restoreConsole = TRUE)
windows()

hist(DTFeb$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks=15,  xlim = c(0, 6))
savePlot(plotfile, type = "png", device = dev.cur())
dev.off()
