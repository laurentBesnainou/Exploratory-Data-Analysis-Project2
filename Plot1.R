library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
png(file = "plot1.png",width = 800, height = 600)
##### base plotting system, make a plot showing the total PM2.5 emission from all 
##### sources for each of the years 1999, 2002, 2005, and 2008
yearNEI <- with(NEI,tapply(Emissions, year, sum, na.rm=TRUE))
plot(names(yearNEI),yearNEI/1000000,pch=20,xlab = "Year", ylim=c(3,8),
     ylab="Tons of PM2.5 emission (in millions)", main="PM2.5 emitted in the United States from 1999 to 2008")

dev.off() ## Close the  file device
