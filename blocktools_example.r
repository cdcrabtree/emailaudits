#### blocking.r
#### R script to illustrate blocking
#### Charles, 01/08/2017
####################################

###############
### Setup R ###
###############
#install.packages("blockTools")

### Clear terminal
cat("\014")

### Clear space
rm(list = ls())

### Load packages
library(blockTools)

###################
### Create Data ###
###################

id <- 1:100
participants <- rep(c("Female Name", "Male Name"), 50)
female <- as.factor(rep(c(0, 1), 50)) ### This is the blocking variable
df <- data.frame(cbind(id, participants, female))
head(df)

######################
### Use blockTools ###
######################

out <- blockTools::block(df, id.vars = "id", block.vars = c("female")) ## create blocked pairs
assg <- assignment(out) ## assign one member of each pair to treatment/control
assg ## inspect object

##################################
### Create treatment indicator ###
##################################

## Assume that 'Treatment 1' in assg object means that the treatment indicator should be '1' and that 'Treatment 2' means that it should be '0'
tr1 <- c(t(cbind(assg$assg[[1]]))[1, ]) ## extract ids from treatment column
tr1 <- as.numeric(tr1) ## convert character vector to numeric
one <- rep(1, 50) ## create vector of '1's
tr1.df <- cbind(tr1, one) ## bind together ids and treatment indicators
colnames(tr1.df) <- c("id", "tr") ## rename columns

tr2 <- t(cbind(assg$assg[[1]]))[2, ] ## extract ids from Treatment 2 column
tr2 <- as.numeric(tr2) ## convert character vector to numeric
zero <- rep(0, 50) ## create vector of '0's
tr2.df <- cbind(tr2, zero) ## bind together ids and treatment indicators
colnames(tr2.df) <- c("id", "tr") ## rename columns

tr.join <- rbind(tr1.df, tr2.df) ## connect two tr.dfs
head(tr.join)

full.df <- merge(df, tr.join, by = "id", all.x = T) ## merge initial df with treatment df
head(full.df)
