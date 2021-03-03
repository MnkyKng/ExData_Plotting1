# load libraries
library(datasets)

# download data file if file nonexistent and unzip if folder nonexistent
destfile <- "household_power_consumption.zip"

if (!file.exists(destfile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile, method = "curl")
}
if (!file.exists("household_power_consumption")){
        unzip(destfile)
}

# read file
hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
str(hpc_data)
head(hpc_data)
tail(hpc_data)

# subset data
hpc_subdata <- subset(hpc_data, Date == "1/2/2007" | Date == "2/2/2007")
str(hpc_subdata)
head(hpc_subdata)
tail(hpc_subdata)

# conversion Date and Time
hpc_datetime <- strptime(paste(hpc_subdata$Date, hpc_subdata$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 
str(hpc_datetime)

# set plot margins and outer margins
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# plot 4: top left
plot(hpc_datetime, as.numeric(hpc_subdata$Global_active_power), xlab = "", ylab = "Global Active Power", type = "l")

# plot 4: top right
plot(hpc_datetime, as.numeric(hpc_subdata$Voltage), xlab = "datetime", ylab = "Voltage", type = "l")

# plot 4: bottom left
plot(hpc_datetime, as.numeric(hpc_subdata$Sub_metering_1), xlab = "", ylab = "Energy sub metering", type = "l")
with(hpc_subdata, lines(hpc_datetime, as.numeric(hpc_subdata$Sub_metering_2), col="red"))
with(hpc_subdata, lines(hpc_datetime, as.numeric(hpc_subdata$Sub_metering_3), col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# plot 4: bottom right
plot(hpc_datetime, as.numeric(hpc_subdata$Global_reactive_power), xlab = "datetime", ylab = "Global_reactive_power", type = "l")

# save plot 4 as png
dev.copy(device = png, file = "plot4.png", width=480, height=480)
dev.off()