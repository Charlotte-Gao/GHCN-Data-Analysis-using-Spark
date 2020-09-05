library(plyr)
library(readr)
library("dplyr")
#setwd("M:/")
#mydir = "temperature_NZ.csv"
#myfiles = list.files(path=mydir, pattern="*.csv", full.names=TRUE)
#myfiles
#dat_csv = ldply(myfiles, read_csv)
dat_csv=read.csv("/Charlotte/shepherding/420scalable/assignment1/temperature.csv")
dat_csv
dat_csv$temperature=dat_csv$temperature/10
head(dat_csv)
#-----plot the average time series for TMIN and TMAX for the entire country--------
temperature_agg=aggregate(dat_csv,by=list(dat_csv$year),FUN=mean)
temperature_agg
attach(temperature_agg)
temperature_type=factor(temperature_type)
plot(temperature~year,type='l',lty=substr(temperature_type,2,3), ylab="temperature(celsius degree)", data = temperature_agg)
tmin=subset(dat_csv,subset = c(temperature_type=="TMIN"))
tmin_agg=aggregate(tmin,by=list(tmin$year),FUN=mean)#aggregate tmin values  by year
tmin_agg
plot(temperature~year,type='l',col='red', ylab="temperature(celsius degree)", data = tmin_agg)
tmax=subset(dat_csv,subset = c(temperature_type=="TMAX"))#aggregate tmax values  by year
tmax_agg=aggregate(tmax,by=list(tmax$year),FUN=mean)
tmax
#plot(temperature~year,type='l',col='green', ylab="temperature(celsius degree)", data = tmax_agg)
lines(tmax_agg$temperature,tmax_agg$year,col='green')
source(file='/Charlotte/shepherding/446GLM/labs/lab3/dual_functions.R')
dualplot(tmin_agg$year,tmin_agg$temperature,tmax_agg$temperature)



