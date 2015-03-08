library(sqldf)

constructPlot4 <- function() {
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Closing all connections
  closeAll <- closeAllConnections()
  
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  png("plot4.png", width=480, height=480)
  
  with(plotData, {
    par(mfcol = c(2,2))
    
    # Plot 1
    plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
    # Plot 2
    plot(dt, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(dt, Sub_metering_2, col="red")
    lines(dt, Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd = 2, bty = "n")
  
    # Plot 3
    plot(dt, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
    # Plot 4
    plot(dt, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
  })
  
  # Closing device connections
  closeDev <- dev.off()
}