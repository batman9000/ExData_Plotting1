remove(list=ls())

varclass=rep("character",9)
rawdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE,colClasses = varclass)
cols<-3:9
rawdata[,cols]<-apply(rawdata[,cols],2,function(x) as.numeric(x))

##remove missing data
rawdata<-na.omit(rawdata)
rawdata2<-rawdata
rawdata2$datetime<-paste(rawdata2$Date, rawdata2$Time, sep=";")
rawdata2$datetime<-dmy_hms(rawdata2$datetime)
rawdata2<-rawdata2[rawdata2$Date %in% c("1/2/2007","2/2/2007"),]

png("plot4.png")
par(mfrow=c(2,2),mar=c(4,4,1,1))
plot(rawdata2$datetime,rawdata2$Global_active_power, type="l", ylab="Global Active Power",xlab="")
plot(rawdata2$datetime,rawdata2$Voltage, type="l", ylab="Voltage",xlab="")
plot(rawdata2$datetime,rawdata2$Sub_metering_1, type="l", ylab="Global Active Power (kilowatts)",xlab="", col="black")
lines(rawdata2$datetime,rawdata2$Sub_metering_2, type="l", col="red")
lines(rawdata2$datetime,rawdata2$Sub_metering_3, type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
plot(rawdata2$datetime,rawdata2$Global_reactive_power, type="l", ylab="Global_reactive_power",xlab="")
dev.off()
