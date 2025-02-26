# Open a PNG graphics device
png("plot2.png", width = 480, height = 480)

# Convert Date and Time to a proper datetime format
filtered_data$Datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S")

# Extract unique days and their positions
day_positions <- seq(from = min(filtered_data$Datetime), 
                     to = max(filtered_data$Datetime), 
                     by = "day")

day_labels <- weekdays(day_positions, abbreviate = TRUE)

# Plot Global Active Power over time
plot(filtered_data$Datetime, filtered_data$Global_active_power, 
     type = "l",  # Line plot
     col = "blue",
     xaxt = "n",  # Remove default x-axis
     main = "Global Active Power Over Time", 
     xlab = "Days", 
     ylab = "Global Active Power (kilowatts)")

# Add custom x-axis labels (Days instead of Dates)
axis(1, at = day_positions, labels = day_labels)

# Close the graphics device
dev.off()
