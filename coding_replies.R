###################
### Description ###
###################

### This is an example of how R could be used to code replies from an email audit study. 
### A slightly modified version of this code was used to code emails for the study 
### reported in Gell-Redman, Visalvanich, Crabtree, and Fariss (2018). If you use the 
### code please cite one (or both!) articles. Thanks!

### Clear space
rm(list=ls())

### Load packages
# Install these packages first if they are not on your system.
library(RCurl)
library(tm)
library(tm.plugin.mail)
library(parallel)

### Convert exported .mbox file into individual emails that are saved in the specified directory.
convert_mbox_eml("", dir = "")

### Load data
load("")

### Change working directory to the directory where the individual emails were saved
setwd("")

### Create a corpus from the individual emails
emails <- VCorpus(DirSource())

### Create outcome measure
response <- 0

### Code email responses
i <- 1
for(i in 1:length(emails))	{
  email_holder <- tolower(paste(unlist(emails[[i]]), collapse=""))
  identified <- email[which(sapply(email, grepl, email_holder, fixed=TRUE))]
  if(length(identified)==0)	{next()}
  response[i] <- 1 
}
