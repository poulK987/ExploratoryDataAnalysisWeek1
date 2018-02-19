#Load dataframe
E <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

library(dplyr)

#Create proper date class column
E <- mutate(E, Date2 = as.Date(Date,"%d/%m/%Y"))

#Create date-time class column of the POSIXct class:
E <- mutate(E, DateTime = as.POSIXct(strptime(paste(E$Date2, E$Time), "%Y-%m-%d %H:%M:%S")))
            
#Extract only relevant subset of time
E <- E[E$Date2 >= as.Date("2007/2/1") & E$Date2 <= as.Date("2007/2/2"), ]

#Set up 2-by-2 plot collection:
par(mfrow=c(2,2))

# 1
plot(x = E$DateTime, y = E$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# 2
plot(x = E$DateTime, y = E$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# 3
plot(x = E$DateTime, y = E$Sub_metering_1,
     col = "black",
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = E$DateTime, y = E$Sub_metering_2, 
      col = "red")
lines(x = E$DateTime, y = E$Sub_metering_3,
      col = "blue")
legend("topright", col = c("black","red","blue"),
       lty = c(1,1),
       bty = "n",
       xjust = 1,
       yjust = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#4
plot(x = E$DateTime, y = E$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

#Save png

dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()
