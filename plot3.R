## This R script loads the household power consumption data set, subset the data to the desired
## time period, and creates a line plot of the of the multiple sets of sub-metering data to
## over the desired time period

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

## Plot 3 - create a line plot visualizing the sub-metering data over time, the plot overlays the three
## different columes of sub-metering data adding the the additional columes as different lines and 
## a corresponding legend, and persisting the plot in png format 

png(file="plot3.png")
with(data2, {
  plot(DateTime, Sub_metering_1, ylab="Energy sub metering",type="l",xlab="")
  points(DateTime, Sub_metering_2,col="red",type="l")
  points(DateTime, Sub_metering_3,col="blue",type="l")
  legend(x="topright",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"),
        lwd=1)
})
dev.off()
