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
      "Submet1",
      "Submet2",
      "Submet3"
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



png(file="plot2.png",width=480,height=480)
plot(
    data$TDform,
    data$Activepower,
    type = "l",
    ylab = "Global Active Power (Kilowatts)", xlab = ""
    )
  

dev.off()