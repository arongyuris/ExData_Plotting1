if (!file.exists("./household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl")
        unzip("./household_power_consumption.zip")
}

plot3data <- read.table("household_power_consumption.txt", header=T, sep=";")
plot3data$DateString <- as.Date(plot3data$Date,"%d/%m/%Y")
plot3data_Feb1and2 <- plot3data[plot3data$DateString == "2007-02-01" | plot3data$DateString == "2007-02-02", ]
plot3data_Feb1and2$Full_Time <- paste(plot3data_Feb1and2$Date, plot3data_Feb1and2$Time)
plot3data_Feb1and2$Full_Time <-  strptime(plot3data_Feb1and2$Full_Time,  "%d/%m/%Y %H:%M:%S")

plot3data_Feb1and2$Sub_metering_1[plot3data_Feb1and2$Sub_metering_1=="?"] <- NA
plot3data_Feb1and2$Sub_metering_2[plot3data_Feb1and2$Sub_metering_2=="?"] <- NA
plot3data_Feb1and2$Sub_metering_3[plot3data_Feb1and2$Sub_metering_3=="?"] <- NA

plot3data_Feb1and2$Sub_metering_1 <- as.numeric(as.character(plot3data_Feb1and2$Sub_metering_1))
plot3data_Feb1and2$Sub_metering_2 <- as.numeric(as.character(plot3data_Feb1and2$Sub_metering_2))
plot3data_Feb1and2$Sub_metering_3 <- as.numeric(as.character(plot3data_Feb1and2$Sub_metering_3))

plot(plot3data_Feb1and2$Full_Time, plot3data_Feb1and2$Sub_metering_1, type="n", ylab="Global Active Power (kilowatts)", xlab = NA)
lines(plot3data_Feb1and2$Full_Time, plot3data_Feb1and2$Sub_metering_1, col = "black")
lines(plot3data_Feb1and2$Full_Time, plot3data_Feb1and2$Sub_metering_2, col = "red")
lines(plot3data_Feb1and2$Full_Time, plot3data_Feb1and2$Sub_metering_3, col = "blue")
legend("topright", cex = 0.5, lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()