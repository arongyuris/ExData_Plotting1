if (!file.exists("./household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl")
        unzip("./household_power_consumption.zip")
}

plot4data <- read.table("household_power_consumption.txt", header=T, sep=";")
plot4data$DateString <- as.Date(plot4data$Date,"%d/%m/%Y")
plot4data_Feb1and2 <- plot4data[plot4data$DateString == "2007-02-01" | plot4data$DateString == "2007-02-02", ]
plot4data_Feb1and2$Full_Time <- paste(plot4data_Feb1and2$Date, plot4data_Feb1and2$Time)
plot4data_Feb1and2$Full_Time <-  strptime(plot4data_Feb1and2$Full_Time,  "%d/%m/%Y %H:%M:%S")

plot4data_Feb1and2$Global_active_power[plot4data_Feb1and2$Global_active_power=="?"] <- NA
plot4data_Feb1and2$Voltage[plot4data_Feb1and2$Voltage=="?"] <- NA

plot4data_Feb1and2$Sub_metering_1[plot4data_Feb1and2$Sub_metering_1=="?"] <- NA
plot4data_Feb1and2$Sub_metering_2[plot4data_Feb1and2$Sub_metering_2=="?"] <- NA
plot4data_Feb1and2$Sub_metering_3[plot4data_Feb1and2$Sub_metering_3=="?"] <- NA

plot4data_Feb1and2$Sub_Global_reactive_power[plot4data_Feb1and2$Global_reactive_power=="?"] <- NA

plot4data_Feb1and2$Global_active_power <- as.numeric(as.character(plot4data_Feb1and2$Global_active_power))
plot4data_Feb1and2$Voltage <- as.numeric(as.character(plot4data_Feb1and2$Voltage))

plot4data_Feb1and2$Sub_metering_1 <- as.numeric(as.character(plot4data_Feb1and2$Sub_metering_1))
plot4data_Feb1and2$Sub_metering_2 <- as.numeric(as.character(plot4data_Feb1and2$Sub_metering_2))
plot4data_Feb1and2$Sub_metering_3 <- as.numeric(as.character(plot4data_Feb1and2$Sub_metering_3))

plot4data_Feb1and2$Global_reactive_power <- as.numeric(as.character(plot4data_Feb1and2$Global_reactive_power))

par(mfrow = c(2, 2))

plot(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Sub_metering_1, type="n", ylab="Global Active Power", xlab = NA, ylim = c(0, 6))
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Global_active_power, col = "black")

      
plot(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Voltage, type="n", ylab="Voltage", xlab = "datetime")
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Voltage, col = "black")


plot(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Sub_metering_1, type="n", ylab="Global Active Power (kilowatts)", xlab = NA)
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Sub_metering_1, col = "black")
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Sub_metering_2, col = "red")
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Sub_metering_3, col = "blue")
legend("topright", cex = 0.1, lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Global_reactive_power, type="n", ylab="Global_reactive_power", xlab = "datetime")
lines(plot4data_Feb1and2$Full_Time, plot4data_Feb1and2$Global_reactive_power, col = "black")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()