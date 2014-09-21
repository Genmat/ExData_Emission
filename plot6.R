# # Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions? 

library(ggplot2)
library(labeling)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIBR <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]
NEILAC <- NEI[NEI$fips=="06037" & NEI$type=="ON-ROAD",]

#Aggregate data by year
aggLAC <- aggregate(list(Emissions=NEILAC$Emissions),
                    list(Year=NEILAC$year), sum)
aggBR <- aggregate(list(Emissions=NEIBR$Emissions),
                    list(Year=NEIBR$year), sum)
#Make Year-to-1999 data
aggLACp <- with(aggLAC, Emissions/Emissions[Year==1999]-1)*100
aggBRp <- with(aggBR, Emissions/Emissions[Year==1999]-1)*100
typeLAC<-c(rep("LAC",length(aggLACp)))
typeBR<-c(rep("BCM",length(aggBRp)))
aggLACp1<-data.frame(aggLAC$Year,aggLACp,typeLAC)
nm<-names(aggLACp1)
#Creating dataframe for plotting
aggBRp1<-data.frame(aggBR$Year,aggBRp,typeBR)
names(aggBRp1) <- c("Year","Change","type")
names(aggLACp1) <- c("Year","Change","type")
comb<-rbind(aggLACp1,aggBRp1)
comb[,3]<-as.factor(comb[,3])
comb
p<- ggplot(comb, aes(Year,Change))
           
# plotting changes           
p1<-p + geom_line(aes(col=type))+geom_point(aes(col=type), size = 3)+
  geom_text(aes(label=(round(Change,2))), hjust=1, vjust=1)+
  labs(y = expression(PM[2.5]*
                                     " % Change from 1999"))+
  labs(title = expression("Motor Vehicle "*PM[2.5]*" Emissions for Baltimore County And Los Angeles County"))
print(p1)


ggsave(p1,file="plot6.png",width=6,height=4,dpi=200)
dev.off()