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

## PLOT 2
png(filename = "plot2.png", width=480, height=480, units = "px")
with(small_hpc_data , plot(datetime
                           , small_hpc_data$Global_active_power, type="l"
                           , xlab=""
                           , ylab="Global Active Power(killowatts)")  
)
dev.off()
