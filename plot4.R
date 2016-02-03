library(data.table)
DT <- fread("household_power_consumption.txt",
            sep=";", header = TRUE, colClasses = rep("character", 9), na.strings = "?")
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02")]
DT$DateandTime <- as.POSIXct(strptime(paste(DT$Date, DT$Time, sep = " "),
                                      format = "%Y-%m-%d %H:%M:%S"))
DT$Global_active_power <- as.numeric(DT$Global_active_power)
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
with(DT, plot(DateandTime, Global_active_power, type = "l", xlab = "",
              ylab = "Global Active Power (kilowatts)"))
with(DT, plot(DateandTime, Voltage, type = "l", xlab = "Date and Time", ylab = "Voltage"))
with(DT, plot(DateandTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(DT, points(DateandTime, Sub_metering_2, type = "l", col = "red"))
with(DT, points(DateandTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", 
                                                               "Sub_metering_3"), lty = 1)
with(DT, plot(DateandTime, Global_reactive_power, type = "l", xlab = "Date and Time",
              ylab = "Global reactive power"))
dev.off()