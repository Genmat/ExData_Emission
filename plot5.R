# # How have emissions from motor vehicle sources changed 
# from 1999–2008 
# in Baltimore City

library(ggplot2)
library(labeling)
#Read Emissions Date
NEI <- readRDS("summarySCC_PM25.rds")

#Read classification table
SCC <- readRDS("Source_Classification_Code.rds")

NEIBR <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

#Aggregate data by year
agg <- aggregate(list(Emissions=NEIBR$Emissions),
                 list(Year=NEIBR$year), sum)

p <- qplot(Year,
           Emissions,
           xlab = "Year", 
           ylab= expression(PM[2.5]*
             " Emissions (tonnes)"),
           data=agg,
           main= expression("Motor Vehicle "*PM[2.5]*" Emissions for Baltimore County, Maryland"),
           geom=c("line","point"),
           color = "steelblue")
p0<- p +theme(legend.position = "none")           
print(p0)

ggsave(p0,file="plot5.png",width=6,height=4,dpi=200)
dev.off()