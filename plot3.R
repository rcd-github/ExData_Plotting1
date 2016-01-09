# load the data from the working directory
library(data.table)
power <- fread("household_power_consumption.txt", nrows=2880, header="auto", skip=66637)
power2 <- fread("household_power_consumption.txt", nrows=3, header="auto")
setnames(power, 1:ncol(power), names(power2)) ; rm(power2)

## convert the date and time variables to "date" and POXIXct classes
power[, `:=` (Date = as.Date(Date, format="%d/%m/%Y"), 
              Time = as.POSIXct(strptime(paste(power$Date,power$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")))]

# create Plot 3
with(power, plot(Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering",
                 cex.axis=0.75, cex.lab=0.75, mgp=c(2.5,1,0)))
with(power, lines(Time, Sub_metering_1, col="black"))
with(power, lines(Time, Sub_metering_2, col="red"))
with(power, lines(Time, Sub_metering_3, col="royalblue"))
legend("topright", lty=1, col=c("black","red","royalblue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.75)
dev.copy(png, file="plot3.png", width=480, height=480) # open graphics device
dev.off() # close graphics device