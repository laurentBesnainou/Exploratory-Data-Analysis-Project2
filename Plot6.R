library(ggplot2)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
#### vehicle sources in Los Angeles County, California (fips == "06037"). 
#### Which city has seen greater changes over time in motor vehicle emissions
NEILA <- subset(NEI,fips == "06037")
vehicles <- grep("Vehicle",SCC$EI.Sector)
SCCvehicle <- SCC[vehicles,]
mrgLA <- merge(NEILA,SCCvehicle, by="SCC")
mrgLA$county="Los Angeles"

NEIBalt <- subset(NEI,fips == "24510")
SCCvehicle <- SCC[vehicles,]
mrgBalt <- merge(NEIBalt,SCCvehicle, by="SCC")
mrgBalt$county="Baltimore City"

mrg <- rbind(mrgBalt,mrgLA)
png(file = "plot6.png",width = 800, height = 600)
mrg %>% group_by(year,county) %>% summarize(total=sum(Emissions,na.rm = TRUE)) %>%
  ggplot(aes(x=year,y=total,colour=county)) +
  geom_point() +facet_grid(.~county)+
  xlab("Year") +
  ylab("Tons PM2.5 emission")+
  theme(legend.position="none")+
  ggtitle("Emissions from motor vehicle sources changed from 1999–2008","in Baltimore City & Los Angeles")
dev.off() ## Close the  file device
