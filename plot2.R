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
cons_data$Global_active_power=as.double(as.character(cons_data$Global_active_power))

sub_data<-cons_data %>% filter(Date>='2007-02-01' & Date<='2007-02-02') %>% mutate(DateTime=as.POSIXct(paste(Date,Time)))


# open  the plotting device and generate the plot
png("plot2.png", width = 480, height = 480)
plot(sub_data$Global_active_power~sub_data$DateTime,  type="l",ylab="Global Active Power (kilowats)", xlab=" ")

# turn off the device
dev.off()
