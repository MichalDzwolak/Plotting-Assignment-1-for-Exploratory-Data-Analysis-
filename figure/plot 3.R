library(dplyr)
library(sqldf)

upload <- read.csv.sql("household_power_consumption.txt" ,sep=";",sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

upload <- mutate(upload,Date.Time=paste(upload$Date,upload$Time)) 

upload <- select(upload,Date.Time,Sub_metering_1,Sub_metering_2,Sub_metering_3) 

upload$Date.Time <- strptime(upload$Date.Time,"%d/%m/%Y %T") 

#Plot
with(upload, plot(Date.Time, Sub_metering_1, type = "n", xaxt = 'n', ylab = "Engergy Sub Metering", xlab = "")) 
with(upload, points(Date.Time, Sub_metering_1, type = "l"))
with(upload, points(Date.Time, Sub_metering_2, type = "l", col="red"))
with(upload, points(Date.Time, Sub_metering_3, type = "l", col="blue"))

#legend
legend("topright", lty =1, cex = 0.7, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Axis
axis(1, at = c(as.numeric(min(upload$Date.Time)), as.numeric(median(upload$Date.Time)), as.numeric(max(upload$Date.Time))), labels = c("Thu","Fri", "Sat")) 

dev.copy(png, "plot3.png", width = 480, height = 480) 

dev.off()