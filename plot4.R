library(tidyverse)

Sys.setlocale("LC_ALL","English")

par(mfrow=c(2,2))

data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Filtered data based on dates "2007-02-01" and "2007-02-02"
data_filtered <- filter(data, (Date == "2007-02-01" | Date == "2007-02-02"))

data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))
data_filtered <- transform(data_filtered, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#Global Active Power
plot(data_filtered$timestamp, data_filtered$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Voltage
data_filtered$Voltage <- as.numeric(as.character(data_filtered$Voltage))
plot(data_filtered$timestamp, data_filtered$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#Energy sub metering
data_filtered$Sub_metering_1 <- as.numeric(as.character(data_filtered$Sub_metering_1))
data_filtered$Sub_metering_2 <- as.numeric(as.character(data_filtered$Sub_metering_2))
data_filtered$Sub_metering_3 <- as.numeric(as.character(data_filtered$Sub_metering_3))

plot(data_filtered$timestamp, data_filtered$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_filtered$timestamp, data_filtered$Sub_metering_2, col = "Red")
lines(data_filtered$timestamp, data_filtered$Sub_metering_3, col = "Blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), cex = 0.5, bty = "n")

#Global Reactive Power
data_filtered$Global_reactive_power <- as.numeric(as.character(data_filtered$Global_reactive_power))
plot(data_filtered$timestamp, data_filtered$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

