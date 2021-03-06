url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")){
    download.file(url, "household_power_consupmption.txt")
    unzip("household_power_consumption.txt")
}
hpc1<-read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
hpc2<-hpc1[hpc1$Date=="2/2/2007" | hpc1$Date=="1/2/2007",]
hpc2$datetime<-paste(hpc2$Date, hpc2$Time)
hpc3<-transform(hpc2, 
                Global_active_power = as.numeric(Global_active_power), 
                Global_reactive_power = as.numeric(Global_reactive_power), 
                Voltage = as.numeric(Voltage),
                Global_intensity = as.numeric(Global_intensity), 
                Sub_metering_1 = as.numeric(Sub_metering_1), 
                Sub_metering_2 = as.numeric(Sub_metering_2), 
                Sub_metering_3 = as.numeric(Sub_metering_3),
                datetime = as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
)
png(file = "plot3.png")
with(hpc3, plot (Sub_metering_1 ~ datetime,
                 type ="n",
                 xlab = "",
                 ylab = "Energy sub metering",
                 ))
with(hpc3, lines(Sub_metering_1 ~ datetime))
with(hpc3, lines(Sub_metering_2 ~ datetime, col = "red"))
with(hpc3, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright",
       lty = 1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
dev.off()