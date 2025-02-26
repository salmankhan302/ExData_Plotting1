install.packages("dplyr")
library(dplyr)
# Open a PNG graphics device
png("plot3.png", width = 480, height = 480)

# Convert Date and Time to a proper datetime format
filtered_data$Datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S")

# Check for missing or invalid Datetime values
filtered_data <- filtered_data %>%
  filter(!is.na(Datetime))

# Extract unique days and their positions
day_positions <- seq(from = min(filtered_data$Datetime), 
                     to = max(filtered_data$Datetime), 
                     by = "day")

day_labels <- weekdays(day_positions, abbreviate = TRUE)

# Plot energy sub-metering
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", col = "black",
     xlab = "DateTime", ylab = "Energy Sub-metering", main = "Energy Sub-metering (Thu, Fri, Sat)",
     xaxt = "n", xlim = range(filtered_data$Datetime))  # Set x-axis limits

# Add lines for Sub_metering_2 and Sub_metering_3
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")

# Add custom x-axis labels (Days instead of Dates)
axis(1, at = day_positions, labels = day_labels)

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)

# Close the graphics device
dev.off()