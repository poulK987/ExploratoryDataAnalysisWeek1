#Load dataframe
E <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

library(dplyr)

#Create proper date class column
E <- mutate(E, Date2 = as.Date(Date,"%d/%m/%Y"))

#Create date-time class column of the POSIXct class:
E <- mutate(E, DateTime = as.POSIXct(strptime(paste(E$Date2, E$Time), "%Y-%m-%d %H:%M:%S")))
            
#Extract only relevant subset of time
E <- E[E$Date2 >= as.Date("2007/2/1") & E$Date2 <= as.Date("2007/2/2"), ]

#Create Plot
plot(x = E$DateTime, y = E$Global_active_power,
    type = "l",
    ylab = "Global Active Power (kilowatts)",
    xlab = "")

#Save png
dev.copy(png, width = 480, height = 480, file = "plot2.png")
dev.off()
