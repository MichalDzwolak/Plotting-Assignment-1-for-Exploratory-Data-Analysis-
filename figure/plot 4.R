library(dplyr)
library(sqldf)

upload <- read.csv.sql("household_power_consumption.txt" ,sep=";",sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

upload <- mutate(upload,Date.Time=paste(upload$Date,upload$Time)) 

upload <- select(upload,Date.Time,Global_active_power,Voltage,Global_reactive_power,Sub_metering_1,Sub_metering_2,Sub_metering_3) 

upload$Date.Time <- strptime(upload$Date.Time,"%d/%m/%Y %T") 

par(mfrow = c(2,2), mar=c(4,4,2,1), oma = c(0,0,2,0))

#1
plot(upload$Date.Time, as.numeric(upload$Global_active_power), ylab = "Global Active Power", type="l", xaxt = 'n', xlab = " ") 

axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat")) 


#2
plot(upload$Date.Time, as.numeric(upload$Voltage), ylab = "Voltage", type="l", xaxt = 'n', xlab = "datetime") 

axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat")) 

#3
with(upload, plot(Date.Time, Sub_metering_1, type = "n", xaxt = 'n', ylab = "Engergy Sub Metering", xlab = "")) 
with(upload, points(Date.Time, Sub_metering_1, type = "l"))
with(upload, points(Date.Time, Sub_metering_2, type = "l", col="red"))
with(upload, points(Date.Time, Sub_metering_3, type = "l", col="blue"))

#legend
legend("topright", lty =1, cex = 0.7, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Axis
axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat"))

#4
plot(upload$Date.Time, as.numeric(upload$Global_reactive_power), ylab = "Global_reactive_power", type="l", xaxt = 'n', xlab = "datetime") 

axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat")) 

dev.copy(png, "plot4.png", width = 480, height = 480) 

dev.off()