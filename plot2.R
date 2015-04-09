## Load data file using data.table and plot graph

fileName <- "household_power_consumption.txt"

# Load all records using fread
all <- read.table(fileName, header=TRUE, sep = ";", na.strings="?")

# get just two days worth of data
dt <- all[which(all$Date == "1/2/2007" | all$Date == "2/2/2007"),]

# create a date class column
dt[, "datetime"] <- with(dt, as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))

# plot lines of global active power vs. days
plot(dt$datetime, dt$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(dt$datetime, dt$Global_active_power, type = "l")

#save to png file
dev.copy(png, "plot2.png")
dev.off()