## Load data file using data.table and plot graph

fileName <- "household_power_consumption.txt"

# Load all records using fread
all <- read.table(fileName, header=TRUE, sep = ";", na.strings="?")

# get just two days worth of data
dt <- all[which(all$Date == "1/2/2007" | all$Date == "2/2/2007"),]

# create a date class column
dt[, "datetime"] <- with(dt, as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))

# plot lines of energy sub metering vs. days
plot(dt$datetime, dt$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_1, type = "l", col = "black")
lines(dt$datetime, dt$Sub_metering_2, type = "l", col = "red")
lines(dt$datetime, dt$Sub_metering_3, type = "l", col = "blue")
# put legends
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save to png file
dev.copy(png, "plot3.png")
dev.off()