plot4 <- function (input = "dataset", cache = TRUE) {
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
        
        ## Set mfrow to 2 by 2
        par(mfrow = c(2, 2))
        
        ## Make plot 1
        plot(dat$Date_time, dat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", cex.lab = .75, cex.axis = .75, cex.main = .75, cex.sub = .75)
        
        ## Make plot 2
        plot(dat$Date_time, dat$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", cex.lab = .75, cex.axis = .75, cex.main = .75, cex.sub = .75)
        
        ## Make plot 3
        plot(dat$Date_time, dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black", cex.lab = .75, cex.axis = .75, cex.main = .75, cex.sub = .75)

        ## Overlay lines on plot 3
        lines(dat$Date_time, dat$Sub_metering_2, type = "l", col = "red")
        lines(dat$Date_time, dat$Sub_metering_3, type = "l", col = "blue")
        
        ## Add legend to plot 3
        legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = c(1,1), lwd = c(1, 1), bty = "n", cex = .5, pt.cex = 1)
        
        ## Make plot 4
        plot(dat$Date_time, dat$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", cex.lab = .75, cex.axis = .75, cex.main = .75, cex.sub = .75)
        
        ## Make plot4.png
        dev.copy(png, file = "plot4.png", width = 800, height = 800)
        dev.off()
        
        ## Output 'dat' or save 'dataset' to Global environment
        if (cache & !cache_present) {
                dataset <<- dat
                return(cat("plot4.png has been saved to working directory and dataset has been cached to environment"))
        } else {
                return(cat("plot4.png has been saved to working directory"))
        }
}
plot4()