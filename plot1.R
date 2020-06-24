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

#generate plot
hist(powerData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 11)

#save plot
png("plot1.png", width = 480, height = 480)

hist(powerData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 11)

dev.off()