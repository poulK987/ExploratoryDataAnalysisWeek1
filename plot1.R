#Load dataframe
E <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

library(dplyr)

#Create proper date class column
E <- mutate(E, Date2 = as.Date(Date,"%d/%m/%Y"))

#Extract only relevant subset of time
E <- E[E$Date2 >= as.Date("2007/2/1") & E$Date2 <= as.Date("2007/2/2"), ]

#Create Histogram
hist(E$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     xlim = c(0,6))

#Save png
dev.copy(png, width = 480, height = 480, file = "plot1.png")
dev.off()
