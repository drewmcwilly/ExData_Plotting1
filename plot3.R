##this file downloads the required energy consumption file from cloudfront.net, prepares it for analysis
## and produces a histogram .png file called plot1.png
  library(dplyr)

  Zfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#downloads the file
download.file(Zfile,destfile="power_consumption.zip")
#reads in the contents of the zip folder
  cons_data<-read.table(unz("power_consumption.zip","household_power_consumption.txt"), header = T, sep=";")

#converts fields as necessary
  cons_data$Date=as.Date(cons_data$Date, "%d/%m/%Y")
  cons_data$Sub_metering_1=as.double(as.character(cons_data$Sub_metering_1))
  cons_data$Sub_metering_2=as.double(as.character(cons_data$Sub_metering_2))
  cons_data$Sub_metering_3=as.double(as.character(cons_data$Sub_metering_3))
  
  sub_data<-cons_data %>% filter(Date>='2007-02-01' & Date<='2007-02-02') %>% mutate(DateTime=as.POSIXct(paste(Date,Time)))


# open  the plotting device and generate the plot
  png("plot3.png", width = 480, height = 480)
  plot(sub_data$Sub_metering_1~sub_data$DateTime,  type="l", ylab="Energy Submetering", xlab="")
  lines(sub_data$DateTime,sub_data$Sub_metering_2, type="l", col="Red")
  lines(sub_data$DateTime,sub_data$Sub_metering_3, type="l", col="Blue")
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("Black","Red","Blue") )

# turn off the device
dev.off()
