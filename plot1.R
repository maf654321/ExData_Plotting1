plot1 <- function (input = "dataset", cache = TRUE) {
        ## Check if input is present, load dataset
        if (!exists(input)) {dataset <- c()}
        if (exists(input) & length(get(input)) == 10) {
                dat <- get(input)
                cache_present <- TRUE
        } else {
                source(list.files(path = ".", pattern = "load_dataset.R", full.names = TRUE, recursive = TRUE)[1])
                cache_present <- FALSE
                dat <- load_dataset(cache = FALSE, quiet = TRUE)
        }
        
        ## Make histogram
        hist(dat$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", cex.lab = .75, cex.axis = .75, cex.main = .75, cex.sub = .75)
        
        ## Make plot1.png
        dev.copy(png, file = "plot1.png", width = 800, height = 800)
        dev.off()
        
        ## Output 'dat' or save 'dataset' to Global environment
        if (cache & !cache_present) {
                dataset <<- dat
                return(cat("plot1.png has been saved to working directory and dataset has been cached to environment"))
        } else {
                return(cat("plot1.png has been saved to working directory"))
        }
}
plot1()