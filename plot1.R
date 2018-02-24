library(tidyverse)

data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
data <- tbl_df(data)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Filtered data based on dates "2007-02-01" and "2007-02-02"
data_filtered <- filter(data, (Date == "2007-02-01" | Date == "2007-02-02"))

data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))

hist(data_filtered$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
