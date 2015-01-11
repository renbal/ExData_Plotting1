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

#merge date and time columns into a single POSIX object
datetimes <- as.POSIXlt(paste(as.character(powerdata$Date), as.character(powerdata$Time)))

#create png graphic device for output, setting width and height to 480 pixels and resolution to 72
png(file="plot4.png", width=480, height=480, res=72)

#set graphical parameters
par(mfrow = c(2,2), bg="transparent")

#create 4 base plots to be saved to png graphic device
with(powerdata, {
  plot(datetimes, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

  plot(datetimes, Voltage, type="l", xlab="datetime")
  
  plot(datetimes, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  #add line plot for Sub_metering_2
  lines(datetimes, Sub_metering_2, type="l", col="red")
  #add line plot for Sub_metering_3
  lines(datetimes, Sub_metering_3, type="l", col="blue")
  #add legend
  legend("topright", lty=c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

  plot(datetimes, Global_reactive_power, type="l", xlab="datetime")
})
  
#shut down current graphic device
dev.off
