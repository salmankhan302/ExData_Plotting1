# Open a PNG graphics device
png("four_plots.png", width = 480, height = 480)

# Set up a 2x2 grid for four plots
par(mfrow = c(2, 2))

# Convert Date and Time to a proper datetime format
filtered_data$Datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S")

# Remove rows with missing or invalid Datetime values
filtered_data <- filtered_data %>%
  filter(!is.na(Datetime))

# Remove rows with missing values in the columns to be plotted
filtered_data <- filtered_data %>%
  filter(!is.na(Global_active_power) & !is.na(Voltage) & 
           !is.na(Sub_metering_1) & !is.na(Sub_metering_2) & 
           !is.na(Sub_metering_3) & !is.na(Global_reactive_power))

# Extract unique days and their positions
day_positions <- seq(from = min(filtered_data$Datetime), 
                     to = max(filtered_data$Datetime), 
                     by = "day")

# Plot 1: Global Active Power
plot(filtered_data$Datetime, filtered_data$Global_active_power, type = "l", col = "black",
     xlab = "DateTime", ylab = "Global Active Power (kilowatts)", main = "Global Active Power",
     xaxt = "n", xlim = range(filtered_data$Datetime))

# Plot 2: Voltage
plot(filtered_data$Datetime, filtered_data$Voltage, type = "l", col = "red",
     xlab = "DateTime", ylab = "Voltage (volts)", main = "Voltage", xaxt = "n", 
     xlim = range(filtered_data$Datetime))

# Plot 3: Energy Sub-metering
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", col = "black",
     xlab = "DateTime", ylab = "Energy Sub-metering", main = "Energy Sub-metering", xaxt = "n", xlim = range(filtered_data$Datetime))
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)

# Plot 4: Global Reactive Power
plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type = "l", col = "blue",
     xlab = "DateTime", ylab = "Global Reactive Power (kilowatts)", main = "Global Reactive Power", xaxt = "n", xlim = range(filtered_data$Datetime))

# Close the graphics device
dev.off()
