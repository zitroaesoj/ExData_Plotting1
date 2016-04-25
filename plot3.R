## set url of zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## set localzip name 
localzip <- "household_power_consumption.zip"

## download zip and save it as localzip
download.file(url, destfile = localzip)

## unzip
unzip(localzip)

## set localfile name
localfile <- "household_power_consumption.txt"

## read localfile into table object
hpcfull <- read.table(localfile, header=TRUE, sep=";", na.strings="?")

## show column names
names(hpcfull)
## [1] "Date" "Time" "Global_active_power" "Global_reactive_power" "Voltage" "Global_intensity" "Sub_metering_1" "Sub_metering_2" "Sub_metering_3" 

## subset 2 days we're going to work with
hpcshort <- subset(hpcfull, Date %in% c("1/2/2007", "2/2/2007"))

## remove hpcfull object since we already pulled 2 days we're working with
rm("hpcfull")

## concat converted date with time to new vector
datetime <- paste(as.Date(hpcshort$Date, format="%d/%m/%Y"), hpcshort$Time)

## add new column from vector datetime 
hpcshort$Datetime <- as.POSIXct(datetime)

## create plot for column Sub_metering_1 by new column Datetime
with(hpcshort, plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

## add lines for column Sub_metering_2 by new column Datetime in red
with(hpcshort, lines(Sub_metering_2~Datetime, col='Red'))

## add lines for column Sub_metering_3 by new column Datetime in blue
with(hpcshort, lines(Sub_metering_3~Datetime, col='Blue'))

## add plot legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## copy to png file as plot3.png set height and width
dev.copy(png, file="plot3.png", height=480, width=480)

## make sure to close file
dev.off()