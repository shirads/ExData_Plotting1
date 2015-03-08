library(sqldf)

constructPlot3 <- function() {
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Prevent any warning message from being displayed
  closeAll <- closeAllConnections()
  
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  png("plot3.png", width=480, height=480)
  with (plotData, plot(dt, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
  with (plotData, lines(dt, Sub_metering_2, col="red"))
  with (plotData, lines(dt, Sub_metering_3, col="blue"))
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd = 2)
  
  # Prevent any warning message from being displayed
  closeDev <- dev.off()
}