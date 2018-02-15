library(ggplot2)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
NEIBalt <- subset(NEI,fips == "24510")

#####   Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#####   which of these four sources have seen decreases in emissions from 1999–2008 
#####   for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
png(file = "plot3.png",width = 800, height = 600)
NEIBalt %>% group_by(year,type) %>% summarize(total=sum(Emissions,na.rm = TRUE)) %>%
  ggplot(aes(x=year,y=total)) +
  geom_point()+facet_grid(.~type) +
  xlab("Year") +
  ylab("Tons PM2.5 emission")+
ggtitle("PM2.5 emitted in Baltimore from 1999 to 2008 by type")
dev.off() ## Close the  file device