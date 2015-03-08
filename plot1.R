# 'plot1.R' generates the 1st plot from the 'household_power_consumption.txt' data set
# It uses the dates between '1/2/2007' and '2/2/2007'
# The plot is generated using the graphics devices as a PNG image called 'plot1.png'

# Load the 'sqldf' library to subset the dataset with the relevant rows
library(sqldf)

constructPlot1 <- function() {
  # Select the rows between '1/2/2007' and '2/2/2007'
  plotData <- read.csv.sql("./household_power_consumption/household_power_consumption.txt",
                       sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                       sep = ";")
  
  # Close all existing connections to prevent the 'read.csv.sql' from being open after the read
  closeAll <- closeAllConnections()
  
  # Open a graphics device
  png("plot1.png", width=480, height=480)
  
  # Plot the data
  with(plotData, hist(Global_active_power, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)"))
  
  # Close the graphics device connection
  closeDev <- dev.off()
}