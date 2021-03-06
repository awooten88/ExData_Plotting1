# Download
myurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(myurl,"household_power_consumption.zip")
unzip("household_power_consumption.zip")

#read-in and format data
mydata<-read.table("household_power_consumption.txt", sep = ";", skip = 1)
names(mydata)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
mydata <- replace(mydata, mydata == "?", NA)
mydata$Date<-as.Date(mydata$Date, format = "%d/%m/%Y")

#subset data
powerData<-subset(mydata,mydata$Date=="2007-02-01" | mydata$Date == "2007-02-02")
powerData[,3:9]<-sapply(powerData[,3:9],as.character)
powerData[,3:9]<-sapply(powerData[,3:9],as.numeric)
powerData$datetime<-as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")

#generate plot
par(mfrow = c(2,2))
#plot1
plot(powerData$datetime,powerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#plot 2
plot(powerData$datetime,powerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#plot 3
plot(powerData$datetime,powerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$datetime,powerData$Sub_metering_2, col = "red")
lines(powerData$datetime,powerData$Sub_metering_3, col = "blue")
legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
#plot 4
plot(powerData$datetime,powerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#save plot
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
#plot1
plot(powerData$datetime,powerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#plot 2
plot(powerData$datetime,powerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#plot 3
plot(powerData$datetime,powerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$datetime,powerData$Sub_metering_2, col = "red")
lines(powerData$datetime,powerData$Sub_metering_3, col = "blue")
legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
#plot 4
plot(powerData$datetime,powerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()