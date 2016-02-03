library(data.table)
DT <- fread("household_power_consumption.txt",
            sep=";", header = TRUE, colClasses = rep("character", 9), na.strings = "?")
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02")]
DT$DateandTime <- as.POSIXct(strptime(paste(DT$Date, DT$Time, sep = " "),
            format = "%Y-%m-%d %H:%M:%S"))
DT$Global_active_power <- as.numeric(DT$Global_active_power)
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(DT, plot(DateandTime, Global_active_power, type = "l", xlab = "",
              ylab = "Global Active Power (kilowatts)"))
dev.off()  