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
#combine date and time 
 
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

plot(data1$Global_active_power ~ data1$Datetime, type = "l",ylab = "Global Active Power", xlab = "")

plot(data1$Voltage ~ data1$Datetime, type = "l",ylab = "Voltage", xlab = "datetime")

plot(data1$Sub_metering_1 ~ data1$Datetime, type = "l",ylab = "Engery Sub metering", xlab = "")
lines(data1$Sub_metering_2 ~ data1$Datetime, col="Red")
lines(data1$Sub_metering_3 ~ data1$Datetime, col="Blue")

plot(data1$Global_reactive_power ~ data1$Datetime, type = "l",ylab = "Global_reactive_Power", xlab = "datatime")
png(file="plot2.png",width = 480, height = 480)
plot(data1$Global_active_power ~ data1$Datetime, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()