library(ggplot2)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")




#### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
NEIBalt <- subset(NEI,fips == "24510")
vehicles <- grep("Vehicle",SCC$EI.Sector)
SCCvehicle <- SCC[vehicles,]
mrg <- merge(NEIBalt,SCCvehicle, by="SCC")
png(file = "plot5.png",width = 800, height = 600)
mrg %>% group_by(year) %>% summarize(total=sum(Emissions,na.rm = TRUE)) %>%
  ggplot(aes(x=year,y=total)) +
  geom_point()+
  xlab("Year") +
  ylab("Tons PM2.5 emission")+
  ggtitle("Emissions from motor vehicle sources changed from 1999–2008","in Baltimore City")
dev.off() ## Close the  file device
