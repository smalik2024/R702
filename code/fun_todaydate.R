TD <- function() {
    x = Sys.Date()
    Year = as.numeric(format(x, "%Y"))
    Month = as.numeric(format(x, "%m"))
    MonthName = format(x, "%B")
    Day = as.numeric(format(x, "%d"))
    print(paste("Today is ", MonthName, Day))
    list(Year = Year, Month = Month, Day = Day)
}