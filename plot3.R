# 'plot3.R' generates the 3rd plot from the 'household_power_consumption.txt' data set
# It uses the dates between '1/2/2007' and '2/2/2007'
# The plot is generated using the graphics devices as a PNG image called 'plot3.png'

# Load the 'sqldf' library to subset the dataset with the relevant rows
library(sqldf)

constructPlot3 <- function() {
  # Select the rows between '1/2/2007' and '2/2/2007'
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Close all existing connections to prevent the 'read.csv.sql' from being open after the read
  closeAll <- closeAllConnections()
  
  # Get and convert the date time to 'POSIXlt'
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  # Open a graphics device
  png("plot3.png", width=480, height=480)
  
  # Plot and subset the data using colors
  with (plotData, plot(dt, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
  with (plotData, lines(dt, Sub_metering_2, col="red"))
  with (plotData, lines(dt, Sub_metering_3, col="blue"))
  
  # Add a legend with the respective colors of the plot lines
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd = 2)
  
  # Close the graphics device connection
  closeDev <- dev.off()
}