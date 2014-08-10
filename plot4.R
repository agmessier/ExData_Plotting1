# Load data.  This file should be run  by calling source("plot4.R") in the directory in which 
# houshold_power_consumption.txt resides.
power<-read.table("household_power_consumption.txt",header=TRUE,sep=';',na.strings="?")

# Create a list of indices corresponding to the relevant date range so we know which data to plot.
library(lubridate)
dates<-as.Date(dmy(power$Date))
indices<-which(dates <= as.Date(dmy("02-02-2007")) & dates >= as.Date(dmy("01-02-2007")))

# subset the data to include only the dates we want.
power_sub<-power[indices,]

# create a time object by merging the date and time for the independent axis.
time=strptime(paste(power_sub$Date,power_sub$Time),"%d/%m/%Y %H:%M:%S")

# open a graphics device called plot4.png
png(file="plot4.png")

# create 2x2 multi-figure plot area
par(mfcol=c(2,2))

# Make sure background is transparent first.
par(bg="transparent")

# Create first plot.  Same as plot 2 in this assignment, but without (kilowatts) on the y label
plot(time,power_sub$Global_active_power,xlab="",ylab="Global Active Power",type="n")
lines(time,power_sub$Global_active_power)

# Create second plot.  Same as plot 3 in this assignment, but witout a line on the border of the legend
plot(time,power_sub$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
lines(time,power_sub$Sub_metering_1)
lines(time,power_sub$Sub_metering_2,col="red")
lines(time,power_sub$Sub_metering_3,col="blue")
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

# Create third plot of Voltage.
plot(time,power_sub$Voltage,xlab="datetime",ylab="Voltage",type="n")
lines(time,power_sub$Voltage)

# Create fourth plot of the reactive power
plot(time,power_sub$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="n")
lines(time,power_sub$Global_reactive_power)

# Close graphics device.
dev.off()
