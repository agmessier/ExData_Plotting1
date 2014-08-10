# Load data.  This file should be run  by calling source("plot2.R") in the directory in which 
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

# open a graphics device called plot2.png
png(file="plot2.png")

# Make sure background is transparent first.
par(bg="transparent")

# Create plot, type 'n' to not draw data, so we can draw lines instead of symbols
plot(time,power_sub$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="n")

# Add line data to the plot
lines(time,power_sub$Global_active_power)

# Close graphics device
dev.off()