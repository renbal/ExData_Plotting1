#load necessary libraries
library(data.table)
library(graphics)
library(grDevices)

#Load data from file, subsetting for just dates 2007-02-01 to 2007-02-02
powerdata <- subset(fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?"), (Date=="1/2/2007") | (Date=="2/2/2007"))

#convert Date and Time columns to POSIX format
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- strftime(as.POSIXlt(powerdata$Time, format="%H:%M:%S"), format="%H:%M:%S")

#convert Global_active_power column to numeric
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

#create png graphic device for output, setting width and height to 480 pixels and resolution to 72
png(file="plot1.png", width=480, height=480, res=72)

#set graphical parameters
par(bg="transparent")

#create plot to be saved to png graphic device
hist(powerdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

#shut down current graphic device
dev.off
