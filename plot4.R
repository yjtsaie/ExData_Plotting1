library(lubridate)
### This code create 4 plot and put then in 2X2 format
con <- file("~./R/household_power_consumption.txt","r") 
full_data <- read.table(con, sep = ";" , header = T , na.strings ="", stringsAsFactors= F) 
close(con) 
full_data$Date <- as.Date(full_data$Date,"%d/%m/%Y")

data1 <- subset(full_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_data)
datetime <- paste(data1$Date, data1$Time)
data1$Datetime <- as.POSIXct(datetime) 
 
## clean data
data1$Global_active_power[data1$Global_active_power=="?"] <- NA 
data1$Global_active_power <- as.numeric(data1$Global_active_power) 

data1$Voltage[data1$Voltage=="?"] <- NA 
data1$Voltage <- as.numeric(data1$Voltage)

data1$Sub_metering_1[data1$Sub_metering_1=="?"] <- NA 
data1$Sub_metering_2[data1$Sub_metering_2=="?"] <- NA
data1$Sub_metering_3[data1$Sub_metering_3=="?"] <- NA

data1$Global_reactive_power[data1$Global_reactive_power=="?"] <- NA 
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power) 

# Start to plot
par(mfrow=c(2,2), oma=c(0,0,0,0))

plot(data1$Datetime, data1$Global_active_power, type = "l",ylab = "Global Active Power", xlab = "")

plot(data1$Datetime, data1$Voltage, type = "l",ylab = "Voltage", xlab = "datetime")

plot(data1$Datetime, data1$Sub_metering_1, type = "l",ylab = "Engery Sub metering", xlab = "")
lines(data1$Datetime, data1$Sub_metering_2, col="Red")
lines(data1$Datetime, data1$Sub_metering_3, col="Blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), bty="n",
       lty = 1, lwd=2, col=c("Black","Red","Blue"), xjust = 1, yjust = 1)
plot(data1$Datetime, data1$Global_reactive_power, type = "l",ylab = "Global_reactive_power", xlab = "datatime")

### plot in to png file
png(file="plot4.png",width = 480, height = 480)
par(mfrow=c(2,2), oma=c(0,0,0,0))
plot(data1$Datetime, data1$Global_active_power, type = "l",ylab = "Global Active Power", xlab = "")
plot(data1$Datetime, data1$Voltage, type = "l",ylab = "Voltage", xlab = "datetime")
plot(data1$Datetime, data1$Sub_metering_1, type = "l",ylab = "Engery Sub metering", xlab = "")
lines(data1$Datetime, data1$Sub_metering_2, col="Red")
lines(data1$Datetime, data1$Sub_metering_3,col="Blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), bty="n",
       lty = 1, lwd=2, col=c("Black","Red","Blue"), xjust = 1, yjust = 1)
plot(data1$Datetime, data1$Global_reactive_power, type = "l",ylab = "Global_reactive_power", xlab = "datatime")
dev.off()
