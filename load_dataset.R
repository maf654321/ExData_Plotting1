load_dataset <- function(cache = TRUE, directory = ".", file = "exdata-data-household_power_consumption.zip", quiet = FALSE) {
        ## Get file path for first matching file
        ##      Returns NA if no such file exists
        file <- list.files(path = directory, pattern = file, full.names = TRUE, recursive = TRUE)[1]
        
        ## Check if file exists
        ## Unzips and reads file into 'dat'
        if (is.na(file)) {
                temp <- tempfile()
                download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, quiet = TRUE)
                filename <- unzip(temp, list = TRUE)[1, 1]
                dat <- read.table(unz(temp, filename), header = TRUE, sep = ";", na.strings = c('?'))
                unlink(temp)
        } else {
                filename <- unzip(file, list = TRUE)[1, 1]
                dat <- read.table(unz(file, filename), header = TRUE, sep = ";", na.strings = c('?'))
        }
        
        ## Define valid dates
        valid_date <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
        
        ## Turn 'Date' column to date vectors and subset 'dat' by dates, make 'Date_time' column
        dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
        dat <- subset(dat, Date == valid_date[1] | Date == valid_date[2])
        dat <- transform(dat, Date_time = as.POSIXct(paste(Date, Time)))
        
        ## Turn columns 3:5 asd 7:9 into numeric vectors
        for (i in seq_along(names(dat)[c(3:5, 7:9)])) {
                dat[[names(dat)[c(3:5, 7:9)][i]]] <- as.numeric(as.character(dat[[names(dat)[c(3:5, 7:9)][i]]]))
        }
        
        ## Output 'dat' or cache 'dataset' to Global environment
        if (!cache) {
                result <- dat
                return(result)
        } else if (quiet) {
                dataset <<- dat
                return()
        } else {
                dataset <<- dat
                return(cat("dataset has been cached to environment"))
        }
}