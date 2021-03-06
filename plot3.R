## Include library
library(dplyr)

## Assignment
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="./hpc.zip")

#hpc_data = read.csv("./data/hpc/household_power_consumption.txt", sep=";",na.strings="?")
hpc_data = read.csv(unz("./hpc.zip", "household_power_consumption.txt"), sep=";",na.strings="?")

hpc_data <- mutate(hpc_data, longdate = paste(Date, Time, sep = " "))

small_hpc_data <- subset(hpc_data
                         , as.Date(strptime(longdate, "%d/%m/%Y %H:%M:%S")) >= as.Date("2007-02-01") & 
                           as.Date(strptime(longdate, "%d/%m/%Y %H:%M:%S")) <= as.Date("2007-02-02"))

small_hpc_data$datetime = strptime(small_hpc_data$longdate, "%d/%m/%Y %H:%M:%S")
rm(hpc_data)

## PLOT 3
png(filename = "plot3.png", width=480, height=480, units = "px")
plot(small_hpc_data$datetime, small_hpc_data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")  
points(small_hpc_data$datetime, small_hpc_data$Sub_metering_1, type="l")  
points(small_hpc_data$datetime, small_hpc_data$Sub_metering_2, type="l", col="red")  
points(small_hpc_data$datetime, small_hpc_data$Sub_metering_3, type="l", col="blue")  
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "Red", "blue"), lwd=1)
dev.off()