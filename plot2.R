## This R script loads the household power consumption data set, subset the data to the desired
## time period, and creates a line plot of the active power consumption in killowatt hours to
## over the desied time period

# Load the source data delimited by ';' into a table converting all of the missing data fields to NA 
data <- read.table('household_power_consumption.txt',sep=";",header=TRUE,na.strings="?")

# Subset the data set to the two days in Feb 
data2 <- subset(data, 
                as.Date(data$Date,format="%d/%m/%Y") >= as.Date("2007-02-01") & 
                as.Date(data$Date, format="%d/%m/%Y") <= as.Date("2007-02-02"))


# Create a new colume in the table of the concatenated Date and Time values
#data2$DateTime <- paste(as.Date(data2$Date, format="%d/%m/%Y"),data2$Time)
#data2$DateTime <- strptime(data2$DateTime, format="%Y-%m-%d %H:%M:%S")

# data2$DateTime <- paste(as.Date(data2$Date, format="%d/%m/%Y"),data2$Time)
data2$DateTime <- strptime(paste(as.Date(data2$Date, 
                                         format="%d/%m/%Y"),data2$Time), 
                           format="%Y-%m-%d %H:%M:%S")

## Plot 2 - create a line plot using the global active power over time, and persisting the plot 
## in png format 
png(file="plot2.png")
with(data2, 
     plot(DateTime, 
          Global_active_power, 
          ylab="Global Active Power (kilowatts)",
          type="l",
          xlab=""))
dev.off()
