# Install data.table package if not already installed
if (!require(data.table)) install.packages("data.table", dependencies = TRUE)

# Load the data.table package
library(data.table)

# Define file path
file_path <- "household_power_data/household_power_consumption.txt"

# Read only the header row to get column names
col_names <- fread(file_path, nrows = 0, sep = ";")

# Read data only for 1st and 2nd February 2007
data <- fread(file_path, sep = ";", na.strings = "?", 
              col.names = names(col_names),
              colClasses = c("character", "character", rep("numeric", 7)))

# Convert Date column to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for the required dates (2007-02-01 and 2007-02-02)
filtered_data <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

# Convert Date and Time columns to POSIXct datetime format
filtered_data$Datetime <- strptime(paste(filtered_data$Date, filtered_data$Time), 
                                   format = "%Y-%m-%d %H:%M:%S")

# Print first few rows to verify
head(filtered_data)


# Open a PNG graphics device
png("plot1.png", width = 480, height = 480)

# Create a histogram of Global Active Power with specified y-axis labels
hist(filtered_data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     breaks = 50,  # Adjust number of bins if needed
     ylim = c(0, 1200),  # Set y-axis limits
     yaxt = "n")  # Suppress default y-axis ticks

# Manually set y-axis labels
axis(2, at = seq(0, 1200, by = 200), labels = seq(0, 1200, by = 200))

# Close the graphics device
dev.off()
