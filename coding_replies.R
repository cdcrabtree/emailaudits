### Automtically code whether participants in an email audit experiment responded. ###
######################################################################################

### Clear space
rm(list=ls())

### Load packages
# Install these packages first if they are not on your system.
library(RCurl)
library(tm)
library(tm.plugin.mail)
library(parallel)

### Set working directory
setwd("~/Dropbox/butler-crabtree/awareness/replication_files/collecting_outcomes_example/")

### Convert .mbox file into individual emails that are saved in the specified directory.
# There are two emails in the .mbox file. One is from jsmith00508@outlook.com. The other is from crabtreec@yahoo.com.
convert_mbox_eml("example.mbox", dir = "temp")

### Load and inspect sample data
# There are three people in our sample. The .mbox file contains emails from two of them. This means that after running all this code, we should have a response outcome measure that is 1 for two participants and 0 for 1 participant.  
load("example-data.RData")
head(data)

### Change working directory to the directory where the individual emails were saved
setwd("temp")

### Create a corpus from the individual emails
emails <- VCorpus(DirSource())

### Create outcome measure
data$response <- 0

### Code email responses
i <- 1
for(i in 1:length(emails))	{
  email_holder <- tolower(paste(unlist(emails[[i]]), collapse=""))
  identified <- data$email[which(sapply(data$email, grepl, email_holder, fixed=TRUE))]
  if(length(identified)==0)	{next()}
  data$response[i] <- 1 
}

### View data
data