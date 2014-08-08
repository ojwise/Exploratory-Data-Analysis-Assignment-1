url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")){
    download.file(url, "household_power_consupmption.txt")
    unzip("household_power_consumption.txt")
}
hpc1<-read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
hpc3<-transform(hpc1, 
                Time = strptime(Time, "%H:%M;$S"),
                Global_active_power = as.numeric(Global_active_power), 
                Global_reactive_power = as.numeric(Global_reactive_power), 
                Voltage = as.numeric(Voltage),
                Global_intensity = as.numeric(Global_intensity), 
                Sub_metering_1 = as.numeric(Sub_metering_1), 
                Sub_metering_2 = as.numeric(Sub_metering_2), 
                Sub_metering_3 = as.numeric(Sub_metering_3)
                )
hpc4<-hpc3[hpc3$Date=="2/2/2007" | hpc3$Date=="1/2/2007",]
png(file = "plot1.png")
hist(hpc4$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts")
dev.off()

