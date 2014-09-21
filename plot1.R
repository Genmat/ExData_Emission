##  "Address the following questions and tasks in your exploratory analysis"
## Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
setwd("D:/R/exdata-data-NEI_data")
dir()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
agg <- tapply(NEI$Emissions,NEI$year,sum)

#Plot data with bar plot
bplt<-barplot(agg, xaxt="n",xlim=c(0,10e6),
        main="PM2.5 Emissions in the United States",
ylab="Year", xlab="Total PM2.5 Emissions (million tons)",
        beside=TRUE, horiz=TRUE)
#add information for better comparability
axis(1,at=c(0,2e6,4e6,6e6,8e6), labels=c(0,2,4,6,8))
text(x= agg, y= bplt, labels=as.character(round(agg/1000000,3)))
#get png copy
dev.copy(png,filename="plot1.png",  width = 480, height = 480)
dev.off ()
dev.off ()