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

## create histogram for column Global_active_power, set main title, x and y labels
with(hpcshort, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red"))

## copy to png file as plot1.png set height and width
dev.copy(png, file="plot1.png", height=480, width=480)

## make sure to close file
dev.off()