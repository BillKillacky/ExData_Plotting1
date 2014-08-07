# plot3.R
# bill.killacky@gmail.com
#

# Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# UCI Web site variable desc: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# UCI Irvine Machine Learning Repository: http://archive.ics.uci.edu/ml/
#
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#    It corresponds to the kitchen, containing mainly a dishwasher, 
#    an oven and a microwave (hot plates are not electric but gas powered).
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#    It corresponds to the laundry room, containing a washing-machine, 
#    a tumble-drier, a refrigerator and a light.
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#    It corresponds to an electric water-heater and an air-conditioner.

setwd("C:/Users/Bill Killacky/Documents/Coursera/ExploratoryDataAnalysis")
getwd()
rm(m,y,bad,good,u,x,s)

fileName <- "household_power_consumption.txt"
epc <- read.table(fileName, sep=";", header=TRUE, na.strings="?")

epc$DateTime <- paste(epc$Date, epc$Time)
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
epc$Time <- strptime(epc$DateTime, "%d/%m/%Y %H:%M:%S")

summary(epc$Date)
s <- epc[epc$Date >= as.Date("2007-02-01", "%Y-%m-%d") & epc$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
summary(s$Date)

rm(epc, fileName)

names(s)


#png(file = "plot3.png", width = 480, height = 480)  ## Open PNG device; create file in my working directory
ylimits1 = max(s$Sub_metering_1)
ylimits2 = max(s$Sub_metering_2)
ylimits3 = max(s$Sub_metering_3)
ylimits = c(0,max(c(ylimits1, ylimits2, ylimits3)))

plot(s$Time, s$Global_active_power, 
     type="n", main="", xlab="", ylab="Energy sub metering", ylim=ylimits)
points(s$Time, s$Sub_metering_1, type="l", col="black")
points(s$Time, s$Sub_metering_2, type="l", col="red")
points(s$Time, s$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#dev.off()

rm(s, ylimits, ylimits1, ylimits2, ylimits3)

