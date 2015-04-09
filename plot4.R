## Load data file using data.table and plot graph

fileName <- "household_power_consumption.txt"

# Load all records using fread
all <- read.table(fileName, header=TRUE, sep = ";", na.strings="?")

# get just two days worth of data
dt <- all[which(all$Date == "1/2/2007" | all$Date == "2/2/2007"),]

# create a date class column
dt[, "datetime"] <- with(dt, as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))

#create 4 quadrants and set scaled down texts, symboles to 0.6
par(mfcol = c(2,2), cex = 0.6)

# create plots
with ( dt, {
       
       # plot lines of global active power vs. days
       plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
       lines(datetime, Global_active_power, type = "l")
       
       # plot lines of energy sub metering vs. days
       plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
       lines(datetime, Sub_metering_1, type = "l", col = "black")
       lines(datetime, Sub_metering_2, type = "l", col = "red")
       lines(datetime, Sub_metering_3, type = "l", col = "blue")
       # put legends
       legend("topright", bty = "n", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       
       # voltage vs. datetime
       plot(datetime, Voltage, type = "n")
       lines(datetime, Voltage, type = "l")
       
       # global reactive power vs. datetime
       plot(datetime, Global_reactive_power, type = "n")
       lines(datetime, Global_reactive_power, type = "l") }
       
)

# save to PNG file
dev.copy(png, "plot4.png")
dev.off()