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

png("plot1.png")
hist(rawdata2$Global_active_power, xlab="Global Active Power (kilowatts)",col="red", main="plot1")
dev.off()