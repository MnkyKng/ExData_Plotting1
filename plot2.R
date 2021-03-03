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

# plot 2
plot(hpc_datetime, as.numeric(hpc_subdata$Global_active_power), xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

# save plot 2 as png
dev.copy(device = png, file = "plot2.png", width=480, height=480)
dev.off()
