library(tidyverse)

Sys.setlocale("LC_ALL","English")

data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Filtered data based on dates "2007-02-01" and "2007-02-02"
data_filtered <- filter(data, (Date == "2007-02-01" | Date == "2007-02-02"))

data_filtered <- transform(data_filtered, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

data_filtered$Sub_metering_1 <- as.numeric(as.character(data_filtered$Sub_metering_1))
data_filtered$Sub_metering_2 <- as.numeric(as.character(data_filtered$Sub_metering_2))
data_filtered$Sub_metering_3 <- as.numeric(as.character(data_filtered$Sub_metering_3))

plot(data_filtered$timestamp, data_filtered$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_filtered$timestamp, data_filtered$Sub_metering_2, col = "Red")
lines(data_filtered$timestamp, data_filtered$Sub_metering_3, col = "Blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

