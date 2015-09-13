if (!file.exists("./household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl")
        unzip("./household_power_consumption.zip")
}

plot1data <- read.table("household_power_consumption.txt", header=T, sep=";")
plot1data$Date <- as.Date(plot1data$Date,"%d/%m/%Y")
plot1data_Feb1and2 <- plot1data[plot1data$Date == "2007-02-01" | plot1data$Date == "2007-02-02", ]

plot1data_Feb1and2$Global_active_power[plot1data_Feb1and2$Global_active_power=="?"] <- NA
plot1data_Feb1and2$Global_active_power <- as.numeric(as.character(plot1data_Feb1and2$Global_active_power))
hist(plot1data_Feb1and2$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()