##setwd("H:/My Documents/29.StatWithR/June17/Exploratory")

setwd("//tlww.net/lildfs/LILHome1/dekercadioc/My Documents/R4_EDA")

library(lubridate)
library(dplyr)
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
         Date == as.Date("2007-02-02") | Date == as.Date("2007-02-01"))
data <- mutate(data, Time = hms(Time))

png(file="plot1.png",width=480,height=480)
hist(
  x = data$Activepower,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (Kilowatts)",
  ylim = c(0, 1200)
)
dev.off()
