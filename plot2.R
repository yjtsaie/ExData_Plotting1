library(lubridate)




con <- file("~./R/household_power_consumption.txt","r") 
full_data <- read.table(con, sep = ";" , header = T , na.strings ="", stringsAsFactors= F) 
close(con) 
full_data1$Date <- as.Date(full_data$Date,"%d/%m/%Y")

data1 <- subset(full_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_data)
datetime <- paste(data1$Date, data1$Time)
data1$Datetime <- as.POSIXct(datetime) 
#combine date and time 
 

data1$Global_active_power[data1$Global_active_power=="?"] <- NA 
data1$Global_active_power <- as.numeric(data1$Global_active_power) 

png(file="plot2.png",width = 480, height = 480)
plot(data1$Global_active_power ~ data1$Datetime, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()