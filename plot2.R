library(sqldf)

constructPlot2 <- function() {
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Prevent any warning message from being displayed
  closeAll <- closeAllConnections()
  
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  png("plot2.png", width=480, height=480)
  with (plotData, plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
  
  # Prevent any warning message from being displayed
  closeDev <- dev.off()
}