##  "Address the following questions and tasks in your exploratory analysis"
## Of the four types of sources indicated by the type
## (point, nonpoint, onroad, nonroad)
## which of these four sources have seen decreases in emissions 
## from 1999–2008 
## for Baltimore City  (fips == "24510")?
### Which have seen increases in emissions from 1999–2008?
## ggplot2 plotting system 
library(ggplot2)
library(labeling)
setwd("D:/R/exdata-data-NEI_data")
dir()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_B <- NEI[NEI$fips == "24510",]
# Aggregate
agg <- aggregate(list(Emissions=NEI_B$Emissions),list(Year=NEI_B$year, 
                                                      Type=NEI_B$type), sum)
args(qplot)
p <- qplot(Year, Emissions,xlab = "Year", 
           ylab="PM2.5 Emissions (tonnes)", 
           main= "PM2.5 Emissions, Baltimore City, 1999-2008", 
           data=agg, facets=.~ Type, geom="step")
print(p)
ggsave(p,file="plot3.png",width=10,height=4,dpi=220)