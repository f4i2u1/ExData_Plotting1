## Load data file using data.table and plot graph

fileName <- "household_power_consumption.txt"

# Load all records using fread
all <- read.table(fileName, header=TRUE, sep = ";", na.strings="?")

# get just two days worth of data
dt <- all[which(all$Date == "1/2/2007" | all$Date == "2/2/2007"),]

# create a date class column
dt[, "datetime"] <- with(dt, as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))

# plot histogram global active power vs. frequency and put labels
hist(dt$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#save to png file
dev.copy(png, "plot1.png")
dev.off()