# plot1.R
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

fileName <- "household_power_consumption.txt"
epc <- read.table(fileName, sep=";", header=TRUE, na.strings="?")

epc$DateTime <- paste(epc$Date, epc$Time)
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
epc$Time <- strptime(epc$DateTime, "%d/%m/%Y %H:%M:%S")

summary(epc$Date)
s <- epc[epc$Date >= as.Date("2007-02-01", "%Y-%m-%d") & epc$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]
summary(s$Date)

rm(epc, fileName)

png(file = "plot1.png", width = 480, height = 480)  ## Open PNG device; create file in my working directory
xlimit <- range(s$Global_active_power)
ylimit <- c(0, 1200)

hist(s$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylim=ylimit)
dev.off()

rm(s, xlimit, ylimit)

