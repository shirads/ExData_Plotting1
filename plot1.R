library(sqldf)

constructPlot1 <- function() {
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                       sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                       sep = ";")
  
  # Prevent any warning message from being displayed
  closeAll <- closeAllConnections()
  
  png("plot1.png", width=480, height=480)
  with(plotData, hist(Global_active_power, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)"))
  
  # Prevent any warning message from being displayed
  closeDev <- dev.off()
}