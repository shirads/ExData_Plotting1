# 'plot2.R' generates the 2nd plot from the 'household_power_consumption.txt' data set
# It uses the dates between '1/2/2007' and '2/2/2007'
# The plot is generated using the graphics devices as a PNG image called 'plot2.png'

# Load the 'sqldf' library to subset the dataset with the relevant rows
library(sqldf)

constructPlot2 <- function() {
  # Select the rows between '1/2/2007' and '2/2/2007'
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                           sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                           sep = ";")
  
  # Close all existing connections to prevent the 'read.csv.sql' from being open after the read
  closeAll <- closeAllConnections()
  
  # Get and convert the date time to 'POSIXlt'
  dt <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")
  
  # Open a graphics device
  png("plot2.png", width=480, height=480)
  
  # Plot the data
  with (plotData, plot(dt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
  
  # Close the graphics device connection
  closeDev <- dev.off()
}