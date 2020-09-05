library(countrycode)
library(maps)
library(maptools)
library(mapproj)
library(mapdata)
library(rworldmap)
df=read.csv('/Charlotte/shepherding/420scalable/assignment1/precipitation/precipitation_every_country.csv')
head(df)
#draw a boxplot to see if there's any outliers
boxplot(df$precipitation)
#detect outliers
outliers=boxplot(df$precipitation)$out
outliers
#remove outliers
df=df[-which(df$precipitation %in% outliers),]
d.df <- data.frame(df)
w4 <- data.frame(d.df$country,data=d.df$precipitation)
colnames(w4)[1] <- "country"
w4$breaks <- cut(w4$data, 5)
w4$code <- countrycode(w4$country,"country.name","iso3c")
##join data to a map to create a spatialPolygonsDataFrame
sPDF <- joinCountryData2Map(w4,joinCode="ISO3",nameJoinColumn="code")
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapDevice()
mapCountryData(mapToPlot=sPDF, nameColumnToPlot="breaks",missingCountryCol="white",oceanCol="lightsteelblue2",colourPalette="heat",mapTitle="precipitation for  each country")
