##  "Address the following questions and tasks in your exploratory analysis"
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##    (fips == "24510")
##    from 1999 to 2008? 
## Base plotting system 
setwd("D:/R/exdata-data-NEI_data")
dir()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_B <- NEI[NEI$fips == "24510",]
## Aggregate
agg <- tapply(NEI_B$Emissions,NEI_B$year,sum)
#Plot data with bar plot
bplt<-barplot(agg, xaxt="n",xlim=c(0,4000),
              main="PM2.5 Emissions in Baltimore County, Maryland",
              ylab="Year", xlab="Total PM2.5 Emissions (million tons)",
              beside=TRUE, horiz=TRUE)
#add information for better comparability
axis(1,at=c(0,10e2,20e2,30e2,40e2), 
     labels=c(0,10,20,30,40))
text(x= agg, y= bplt, labels=as.character(round(agg/100,3)))

dev.copy(png, filename="plot2.png",  width = 480, height = 480)
dev.off()
dev.off()