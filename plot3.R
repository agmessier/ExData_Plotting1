# Load data.  This file should be run  by calling source("plot3.R") in the directory in which 
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

# open a graphics device called plot3.png
png(file="plot3.png")

# Make sure background is transparent first.
par(bg="transparent")

# Create plot, type 'n' to not draw data, so we can draw lines instead of symbols
plot(time,power_sub$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")

# Draw line graphs for the 3 metering data sets.
lines(time,power_sub$Sub_metering_1)
lines(time,power_sub$Sub_metering_2,col="red")
lines(time,power_sub$Sub_metering_3,col="blue")

# add a legend in the top right corner
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# close graphics device
dev.off()
