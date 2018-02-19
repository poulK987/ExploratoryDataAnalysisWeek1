#Load dataframe
E <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

library(dplyr)

#Create proper date class column
E <- mutate(E, Date2 = as.Date(Date,"%d/%m/%Y"))

#Create date-time class column of the POSIXct class:
E <- mutate(E, DateTime = as.POSIXct(strptime(paste(E$Date2, E$Time), "%Y-%m-%d %H:%M:%S")))
            
#Extract only relevant subset of time
E <- E[E$Date2 >= as.Date("2007/2/1") & E$Date2 <= as.Date("2007/2/2"), ]

#Create plot
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
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Save png
dev.copy(png, width = 480, height = 480, file = "plot3.png")
dev.off()
