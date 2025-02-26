# Open a PNG graphics device
png("plot4.png", width = 800, height = 800)

# Set up a 2x2 grid for four plots
par(mfrow = c(2, 2))

# Plot 1: Global Active Power on Thursday, Friday, and Saturday
plot(filtered_data$DateTime, filtered_data$Global_active_power, type = "l", col = "black",
     xlab = "DateTime", ylab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Plot 2: Voltage on Thursday, Friday, and Saturday
plot(filtered_data$DateTime, filtered_data$Voltage, type = "l", col = "red",
     xlab = "DateTime", ylab = "Voltage (volts)", main = "Voltage")

# Plot 3: Energy Sub-metering on Thursday, Friday, and Saturday
plot(filtered_data$DateTime, filtered_data$Sub_metering_1, type = "l", col = "black",
     xlab = "DateTime", ylab = "Energy Sub-metering", main = "Energy Sub-metering")
lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.8)

# Plot 4: Global Reactive Power on Thursday, Friday, and Saturday
plot(filtered_data$DateTime, filtered_data$Global_reactive_power, type = "l", col = "blue",
     xlab = "DateTime", ylab = "Global Reactive Power (kilowatts)", main = "Global Reactive Power")

# Close the graphics device
dev.off()