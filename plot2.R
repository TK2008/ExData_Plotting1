library(tidyverse)

Sys.setlocale("LC_ALL","English")

data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Filtered data based on dates "2007-02-01" and "2007-02-02"
data_filtered <- filter(data, (Date == "2007-02-01" | Date == "2007-02-02"))

data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))

data_filtered <- transform(data_filtered, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

plot(data_filtered$timestamp, data_filtered$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
