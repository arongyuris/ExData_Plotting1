if (!file.exists("./household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl")
        unzip("./household_power_consumption.zip")
}

plot2data <- read.table("household_power_consumption.txt", header=T, sep=";")
plot2data$DateString <- as.Date(plot2data$Date,"%d/%m/%Y")
plot2data_Feb1and2 <- plot2data[plot2data$DateString == "2007-02-01" | plot2data$DateString == "2007-02-02", ]
plot2data_Feb1and2$Full_Time <- paste(plot2data_Feb1and2$Date, plot2data_Feb1and2$Time)
plot2data_Feb1and2$Full_Time <-  strptime(plot2data_Feb1and2$Full_Time,  "%d/%m/%Y %H:%M:%S")

plot2data_Feb1and2$Global_active_power[plot2data_Feb1and2$Global_active_power=="?"] <- NA
plot2data_Feb1and2$Global_active_power <- as.numeric(as.character(plot2data_Feb1and2$Global_active_power))
plot(plot2data_Feb1and2$Full_Time, plot2data_Feb1and2$Global_active_power,type="n", ylab="Global Active Power (kilowatts)", xlab = NA)
lines(plot2data_Feb1and2$Full_Time, plot2data_Feb1and2$Global_active_power)

dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off()

