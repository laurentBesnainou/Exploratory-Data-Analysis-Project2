library(ggplot2)
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#####  Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
coalSCC <- grep("Coal",SCC$Short.Name)
mrg <- merge(NEI,SCC[coalSCC,], by="SCC")
png(file = "plot4.png",width = 800, height = 600)
mrg %>% group_by(year) %>% summarise(total=sum(Emissions,na.rm = TRUE)) %>%
  ggplot(aes(x=year,y=total)) +
  geom_point()+
  xlab("Year") +
  ylab("Tons PM2.5 emission")+
  ggtitle("Emissions from coal combustion-related sourcesfrom 1999–2008"," Across the United States")
dev.off() ## Close the  file device
