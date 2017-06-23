library(dplyr)
library(sqldf)

upload <- read.csv.sql("household_power_consumption.txt" ,sep=";",sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")


upload <- mutate(upload,Date.Time=paste(upload$Date,upload$Time)) 

upload <- select(upload,Date.Time,Global_active_power) 

upload$Date.Time <- strptime(upload$Date.Time,"%d/%m/%Y %T") 

plot(upload$Date.Time, as.numeric(upload$Global_active_power), ylab = "Global Active Power(kilowatts)", type="l", xaxt = 'n', xlab = " ") 

axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat")) 

dev.copy(png, "plot2.png", width = 480, height = 480) 

dev.off()