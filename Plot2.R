ibrary(ggplot2)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
NEIBalt <- subset(NEI,fips == "24510")
yearBalt <- with(NEIBalt,tapply(Emissions, year, sum, na.rm=TRUE))


png(file = "plot2.png",width = 800, height = 600)
plot(names(yearBalt),yearBalt,pch=20,xlab = "Year",
     ylab="Tons PM2.5 emission", main="PM2.5 emitted in Baltimore from 1999 to 2008")
dev.off() ## Close the  file device