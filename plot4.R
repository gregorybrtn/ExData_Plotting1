# READ AND PREPARE DATA
dataFile <- "./data/household_power_consumption.txt"
## Read and create a dataframe from the file named 'dataFile'. Assign to 'powerData'.
powerData <- read.table(dataFile,
                        header=TRUE,  ## The file's first line names the variables.
                        sep=";") ## The values are separated by semicolons.
## Convert the character values in the 'Date' column of the 'powerData' dataframe to
## objects of class Date. Assign to replace the 'Date' column.
powerData$Date <- as.Date(powerData$Date, 
                          format="%d/%m/%Y") ## Their format is Day/Month/Year. 
## Create a dataframe that is a subset of the 'powerData' dataframe that includes
## all the original columns but includes only rows where the 'Date' variable's
## value is either 2007-02-01 or 2007-02-02. Assign to 'ssPowerData'.
ssPowerData <- powerData[(powerData$Date=="2007-02-01") | 
                                 (powerData$Date=="2007-02-02"),]
## Coerce the values in the Global_active_power, Global_reactive_power, and Voltage
## columns of 'ssPowerData' first to character type then to numeric type.
ssPowerData$Global_active_power <- as.numeric(as.character
                                              (ssPowerData$Global_active_power))
ssPowerData$Global_reactive_power <- as.numeric(as.character
                                                (ssPowerData$Global_reactive_power))
ssPowerData$Voltage <- as.numeric(as.character(ssPowerData$Voltage))
ssPowerData$Sub_metering_1 <- as.numeric(as.character(ssPowerData$Sub_metering_1))
ssPowerData$Sub_metering_2 <- as.numeric(as.character(ssPowerData$Sub_metering_2))
ssPowerData$Sub_metering_3 <- as.numeric(as.character(ssPowerData$Sub_metering_3))
## Modify the data frame 'ssPowerData' to add a column named 'timestamp'. The values
## in 'timestamp' are the concatenated values of 'Date' and 'Time' converted to the
## POSIXct class.
ssPowerData <- transform(ssPowerData, timestamp=as.POSIXct(paste(Date, Time)))

# PLOT
## Assign to 'plot4' a new function that does the following:
plot4 <- function() {
        ## Set the graphical parameters so that figures will be drawn in a
        ## 2 x 2 array by rows
        par(mfrow=c(2,2))
        ## Plot 1
        ## Make a plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame and y coordinates from the 'Global_active_power'
        ## column of the 'ssPowerData' data frame.
        plot(ssPowerData$timestamp, ssPowerData$Global_active_power,
             type="l", ## Make it a line type plot
             xlab="", ## Leave a blank x-axis label
             ylab="Global Active Power") ## Label the y-axis
        ## Plot 2
        ## Make a plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame and y coordinates from the 'Voltage'
        ## column of the 'ssPowerData' data frame.
        plot(ssPowerData$timestamp, ssPowerData$Voltage, 
             type="l", ## Make it a line type plot
             xlab="datetime", ## Label the x-axis 'datetime'
             ylab="Voltage") ## Label the y-axis 'Voltage'
        ## Plot 3
        ## Make a plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame and y coordinates from the 'Sub_metering_1'
        ## column of the 'ssPowerData' data frame.
        plot(ssPowerData$timestamp,ssPowerData$Sub_metering_1, 
             type="l", ## Make it a line type plot
             xlab="", ## Leave a blank x-axis label
             ylab="Energy sub metering") ## Label the y-axis
        ## Add a line plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame and y coordinates from the 'Sub_metering_2'
        ## column of the 'ssPowerData' data frame.
        lines(ssPowerData$timestamp, ssPowerData$Sub_metering_2,
              col="red") ## Plot in red color
        ## Add a line plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame and y coordinates from the 'Sub_metering_3'
        ## column of the 'ssPowerData' data frame.
        lines(ssPowerData$timestamp, ssPowerData$Sub_metering_3,
              col="blue") ## Plot in blue color
        ## Add a legend to the topright corner of the graphic
        legend("topright", 
               col=c("black","red","blue"), ## Use colors black, red, and blue.
               ## Add text with appropriate name of Sub_metering for each color.
               c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
               lty=c(1,1), ## Use line type 1
               bty="n", ## Use box type 'n' to remove it from around the legend
               cex=.5) ## Lower the character expansion factor to make enough room
        ## Plot 4
        ## Make a plot with x coordinates from the 'timestamp' column of the
        ## 'ssPowerData' data frame, y coordinates from the 'Global_reactive_power'
        ## column of the 'ssPowerData' data frame.
        plot(ssPowerData$timestamp,ssPowerData$Global_reactive_power, 
             type="l", ## Make it a line type plot
             xlab="datetime", ## Label the x-axis 'datetime'
             ylab="Global_reactive_power") ## Label y-axis 'Global_reactive_power'
        ## Copy to PNG
        ## Copy the graphics from the graphics device to png. Name the file
        ## 'plot4.png'. Make the file image size 480 x 480.
        dev.copy(png, file="plot4.png", width=480, height=480)
        ## Shut down png as the graphics device.
        dev.off()
        ## Output the concatenation of 'Plot2.png has been saved in' and the address
        ## of the current working directory.
        cat("plot4.png has been saved in", getwd())
}
plot4()