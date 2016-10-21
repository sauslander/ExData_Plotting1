## Subsetting data to get into a format for plots

## use for later date filtering
a <- "2007-02-01"
a_date <- as.Date(a, format = "%Y-%m-%d")

b <- "2007-02-02"
b_date <- as.Date(b, format = "%Y-%m-%d")

## read in raw data
data_raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
date_raw <- as.Date(data_raw[, "Date"], "%d/%m/%Y")

## combine new formatted date with rest of the data
data_raw_2 <- cbind(date_raw, data_raw)

## filter data to only specified dates
data_raw_f <- which(data_raw_2[, "date_raw"] == a_date)
data_raw_f_1 <- which(data_raw_2[, "date_raw"] == b_date)

data_raw_3 <- data_raw_2[data_raw_f, ]
data_raw_3_1 <- data_raw_2[data_raw_f_1, ]

## combine data for those days
data_raw_new <- rbind(data_raw_3, data_raw_3_1)

## format time and metric columns and add to data set
st_time <- strptime(data_raw_new[,3], "%H:%M:%S")

i <- c(4,5,6,7,8,9,10)

data_raw_3_a <- apply(data_raw_new[, i], 2, as.numeric)

## use data plot 1 for plots

data_plot_1 <- cbind(data_raw_3_a, "Date_and_Time" = as.POSIXct(paste(data_raw_new$date_raw, data_raw_new$Time)))

## histogram_1

data_plot_hist <- data_plot_1[, 1]
hist(data_plot_hist)
hist(data_plot_hist, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
