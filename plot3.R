setwd("//tlww.net/lildfs/LILHome1/dekercadioc/My Documents/R4_EDA")

library(lubridate)
library(dplyr)
library(tidyr)
Sys.setlocale("LC_ALL", "English")
data <-
  read.csv2(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    dec = ".",
    col.names = c(
      "Date",
      "Time",
      "Activepower",
      "Reactivepower",
      "Voltage",
      "Intensity",
      "Sub_metering_1",
      "Sub_metering_2",
      "Sub_metering_3"
    ),
    na.strings = "?"
  )
data <- mutate(data, Date = dmy(Date))
data <-
  filter(data,
         Date == as.Date("2007-02-02") |
           Date == as.Date("2007-02-01"))
Time2 <- strptime(data$Time, format = "%H:%M:%S")
Time2 <- format(Time2, "%H:%M:%S")
data <- cbind.data.frame(data, Time2)
data = unite(data, TimeDay, Date, Time2)
TDform <- strptime(data$TimeDay, format = "%Y-%m-%d_%H:%M:%S")
data <- cbind.data.frame(data, TDform)


png(file="plot3.png",width=480,height=480)
plot(x = data$TDform, y = data$Sub_metering_1, type = "l",
     ylab = "", xlab = "", ylim=c(0, 40)
)

par(new=TRUE)

plot(x = data$TDform, y = data$Sub_metering_2, type = "l",
     ylab = "", xlab = "", ylim=c(0, 40), col = "red", lty = 1
)

par(new=TRUE)
plot(x = data$TDform, y = data$Sub_metering_3, type = "l",
     ylab = "Energy sub metering", xlab = "", ylim=c(0, 40), col = "blue", lty = 1 
)

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)



dev.off()