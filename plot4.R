## This R script loads the household power consumption data set, subset the data to the desired
## time period, and creates a composite of of plots visualizing the active power consumption in 
## killowatt hours, voltage, multiple sub-metering columes, and reactive power over the desired 
## time period

# Load the source data delimited by ';' into a table converting all of the missing data fields to NA 
data <- read.table('household_power_consumption.txt',sep=";",header=TRUE,na.strings="?")

# Subset the data set to the two days in Feb 
data2 <- subset(data, 
                as.Date(data$Date,format="%d/%m/%Y") >= as.Date("2007-02-01") & 
                as.Date(data$Date, format="%d/%m/%Y") <= as.Date("2007-02-02"))

# Create a new colume in the table of the concatenated Date and Time values
data2$DateTime <- strptime(paste(as.Date(data2$Date, 
                                         format="%d/%m/%Y"),data2$Time), 
                           format="%Y-%m-%d %H:%M:%S")

## Plot 4 - create a 2 x 2 composite plot containing; 
##  1) line plot showing the global active power over time, 
##  2) line plot showing the Voltage over time,
##  3) create a line plot using the sub-metering data over time, the plot overlays the three
##     different columes of sub-metering data adding the the additional columes as different 
##     lines and a corresponding legend,
##  4) line plot showing the Voltage over time,
## and persisting the plot in png format 

png(file="plot4.png")
par(mfrow=c(2,2))
with(data2, {
  plot(DateTime, Global_active_power, ylab="Global Active Power",type="l",xlab="")
  plot(DateTime, Voltage,type="l", xlab="datetime")
  {
    plot(DateTime, Sub_metering_1, ylab="Energy sub metering",type="l",xlab="")
    points(DateTime, Sub_metering_2,col="red",type="l")
    points(DateTime, Sub_metering_3,col="blue",type="l")
    legend(x="topright",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           lwd=1)
  }
  plot(DateTime, Global_reactive_power,type="l", xlab="datetime")      
})
dev.off()
