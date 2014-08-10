# Load data.  This file should be run  by calling source("plot1.R") in the directory in which 
# houshold_power_consumption.txt resides.  The instructions say the script should load the data.
# I took this to mean that it would already be downloaded and unzipped and we just need to load it.
power<-read.table("household_power_consumption.txt",header=TRUE,sep=';',na.strings="?")

# Create a list of indices corresponding to the relevant date range so we know which data to plot.
library(lubridate)
dates<-as.Date(dmy(power$Date))
indices<-which(dates <= as.Date(dmy("02-02-2007")) & dates >= as.Date(dmy("01-02-2007")))

# subset the data to include only the dates we want.
power_sub<-power[indices,]

# open a graphics device called plot1.png
png(file="plot1.png")

# Make sure the background is transparent first
par(bg="transparent")

# Draw histogram
hist(power_sub$Global_active_power,col='red',main="Global Active Power",xlab="Global Active Power (kilowatts)")

# close graphics device
dev.off()