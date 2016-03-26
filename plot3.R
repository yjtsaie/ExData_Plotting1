library(lubridate)
# get working data set
con <- file("~./R/household_power_consumption.txt","r") 
full_data <- read.table(con, sep = ";" , header = T , na.strings ="", stringsAsFactors= F) 
close(con) 
full_data$Date <- as.Date(full_data$Date,"%d/%m/%Y")

data1 <- subset(full_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_data)

## cleaning data set 
datetime<-paste(data1$Date, data1$Time)
data1$Datetime <- as.POSIXct(datetime) 

data1$Sub_metering_1[data1$Sub_metering_1=="?"] <- NA 
data1$Sub_metering_2[data1$Sub_metering_2=="?"] <- NA
data1$Sub_metering_3[data1$Sub_metering_3=="?"] <- NA

## plot on screen 
plot(data1$Datetime,data1$Sub_metering_1, type = "l",ylab = "Engery Sub metering", xlab = "")
lines(data1$Sub_metering_2 ~ data1$Datetime, col="Red")
lines(data1$Sub_metering_3 ~ data1$Datetime, col="Blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"),
        lty = 1, lwd=2, col=c("Black","Red","Blue"), xjust = 1, yjust = 1)
       
## create plot3.png file 
png(file="plot3.png",width = 480, height = 480)
plot(data1$Datetime,data1$Sub_metering_1, type = "l",ylab = "Engery Sub metering", xlab = "")
lines(data1$Sub_metering_2 ~ data1$Datetime, col="Red")
lines(data1$Sub_metering_3 ~ data1$Datetime, col="Blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"),
       lty = 1, lwd=2, col=c("Black","Red","Blue"), xjust = 1, yjust = 1)
dev.off()
