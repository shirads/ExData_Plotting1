# 'plot3.R' generates the 4th plot from the 'household_power_consumption.txt' data set
# It uses the dates between '1/2/2007' and '2/2/2007'
# The plot is generated using the graphics devices as a PNG image called 'plot4.png'
# The plots is arranged column-wise

# Load the 'sqldf' library to subset the dataset with the relevant rows
library(sqldf)

constructPlot4 <- function() {
  # Select the rows between '1/2/2007' and '2/2/2007'
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Closing all existing connections to prevent the 'read.csv.sql' from being open after the read
  closeAll <- closeAllConnections()
  
  # Getting and converting the date time to 'POSIXlt'
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  # Open a graphics device
  png("plot4.png", width=480, height=480)
  
  with(plotData, {
    # Arrange the plots by (row, column) in column-wise order
    par(mfcol = c(2,2))
    
    # Plot 1
    plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
    # Plot 2, subset data with colors
    plot(dt, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(dt, Sub_metering_2, col="red")
    lines(dt, Sub_metering_3, col="blue")
    
    # Adding legend for Plot 2 with the respective colors of the plot lines
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd = 2, bty = "n")
  
    # Plot 3
    plot(dt, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
    # Plot 4
    plot(dt, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
  })
  
  # Closing graphics device connections
  closeDev <- dev.off()
}