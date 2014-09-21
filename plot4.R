# Across the United States, how have emissions 
# from coal combustion-related sources 
# changed from 1999–2008?
# 

library(ggplot2)
library(labeling)
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

#Filter by keywords in industry
coal <- SCC[grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | 
                 grepl("Lignite", SCC$SCC.Level.Three, ignore.case=TRUE),1]
#Filter data 
NEIfact <- subset(NEI, as.numeric(SCC) %in% coal)

agg <- aggregate(list(Emissions=NEIfact$Emissions),
                 list(Year=NEIfact$year), sum)

p <- qplot(Year, Emissions,xlab = "Year", 
           ylab= expression(PM2.5*" Emissions (tonnes)"), 
           main= expression(PM2.5*" Emissions from Coal 
                            Combustion-related Sources in the US"), 
           data=agg, geom=c("line","point"))
print(p)
ggsave(p,file="plot4.png",width=10,height=4,dpi=220)
dev.off()