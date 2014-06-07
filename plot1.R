## This R script loads the household power consumption data set, subset the data to the desired
## time period, and creates a histogram plot of the active power consumption in killowatt hours to
## frequency of the consumption level

# Load the source data delimited by ';' into a table converting all of the missing data fields to NA 
data <- read.table('household_power_consumption.txt',sep=";",header=TRUE,na.strings="?")

# Subset convert the data format and the data set to the two days in Feb 
data2 <- subset(data, 
                as.Date(data$Date,format="%d/%m/%Y") >= as.Date("2007-02-01") & 
                as.Date(data$Date, format="%d/%m/%Y") <= as.Date("2007-02-02"))

## Plot 1 - create a histogram using the global active power, persist the plot in png format 
png(file="plot1.png")
with(data2,
  hist(as.numeric(Global_active_power), 
       main = "Global Active Power", 
       xlab="Global Active Power (kilowatts)",
       col="red")
)
dev.off()
