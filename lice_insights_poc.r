# Aquahack 18 - Proof of concept
# Berent Lunde
# 07.05.2018


# Path
setwd("C:/Users/Berent/Dropbox/Aquahack18 (1)/prototype v1")
PATH <- "../input/AquaCloud/"

# Packages
library(data.table)
library(dplyr)
library(ggplot2)
library(RJSONIO)


# Read data

data <- fread(paste0(PATH,"LICECOUNT_GRIEG.csv"), sep=",", na.strings = "", stringsAsFactors=T)
sample_size <- 10

#### Visualize data
colnames(data)
View(data)
str(data)

data$date <- as.Date(data$date, format="%m/%d/%Y")

lice_type <- unique(data$stage)
lice_type
# Only consider LEPO
lice_type_considering <- as.character(lice_type[1:3])
data <- data[stage %in% lice_type_considering]

data2 <- data[ with(data, order(populationId,date))]
View(data2)
# Found missing data
# Cleaning missing
# data3 should have complete records
LOG <- LOG[, lag.date := c(NA , date[-.N]), by=msno]
trans[, is_discount := ifelse(discount > 0, 1, 0)]
by=list(adShown,url)
dt1[, lapply(.SD,sum), by=list(year,group)][, if (sum(amt) > 100) .SD, by=group]

data3 <- data2[, num_group := .N, by=list(populationId,date)]

# MANUELLY - TAKE DATA
data3 <- data2[num_group == 3]
data4 <- data3[, num_records := .N, by=list(populationId)]
setorder(data4,-num_records)
setorder(data4,-num_records)

data5 <- data4[1:data4$num_records[1],]
View(data5)

data3 <- data2[1:3,]
View(data3)
data3

# Make into



attach(data)
hist(count)
hist(count/sample_size)
sum(count > 5) / length(count)
detach(data)


# SIMULATE
DF <- data.frame(
    lice = rpois(30, 0.4)
)
DF

# SAVE
fwrite(DF, file=paste0(PATH,"lice_salmon.csv"), sep=",", na = "")

# LOAD
data <- fread(paste0(PATH,"lice_salmon.csv"), sep=",", na.strings = "")

# SIMULATE
DF <- data.frame(
    lice = rpois(30, 0.4)
)
DF

data <- rbind(data, DF)
# SAVE
fwrite(data, file=paste0(PATH,"lice_salmon_additional.csv"), sep=",", na = "")

# LOAD
data_large <- fread(paste0(PATH,"lice_salmon_additional.csv"), sep=",", na.strings = "")


#data
#sum(data$lice)
nobs <- nrow(data)

# Sample function

B <- 10000
mean.lice <- mean(data$lice)
mean.lice.b <- numeric(B)
for(b in 1:B){
    ind.b <- sample(nobs, replace=T)
    mean.lice.b[b] <- mean(data$lice[ind.b])
}
#hist(mean.lice.b)
#sum(mean.lice.b>= 0.5) / B
#DF.b <- data.frame(Lice_count = mean.lice.b)

treshold <- 0.1
decision_support <- ifelse(sum(mean.lice.b>= 0.5) / B >= treshold, "telle_meir_lus", "ikkje_telle_lus")

mean.lice
hist(mean.lice.b, freq=F); lines(density(mean.lice.b), col="red");
decision_support




# Create sample


# Compute insight
