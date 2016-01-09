# load the data from the working directory
library(data.table)
power <- fread("household_power_consumption.txt", nrows=2880, header="auto", skip=66637)
power2 <- fread("household_power_consumption.txt", nrows=3, header="auto")
setnames(power, 1:ncol(power), names(power2)) ; rm(power2)

## convert the date and time variables to "date" and POXIXct classes
power[, `:=` (Date = as.Date(Date, format="%d/%m/%Y"), 
              Time = as.POSIXct(strptime(paste(power$Date,power$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")))]

# create Plot 2
with(power, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)",
                 cex.axis=0.75, cex.lab=0.75, mgp=c(2.5,1,0)))
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()