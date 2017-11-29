###################
### Description ###
###################

### This is an example of how R could be used to implement an email audit study. 
### A slightly modified version of this code was used to deliver emails for the 
### study described in Butler and Crabtree (2017) and the study reported in 
### Gell-Redman, Visalvanich, Crabtree, and Fariss (2018). If you use the code 
### please cite one (or both!) articles. Thanks!

###############
### Setup R ###
###############

### Clear terminal
cat("\014")

### Clear space
rm(list = ls())

### Load package to send emails
library(mailR)

### Email delivery loop. Depending on your data and needs, you might need or want to skip some of the steps in the loop.
for(i in 1:nrow(data))  { # Loop goes through every observation in the 'data' dataframe
  title <- as.vector(data$title[i]) # Create vector that contains job title for the current observation
  recipient.name <- as.vector(data$name[i]) # Create vector that contains the recipient name for the current observation
  j <- as.vector(data$text[i]) # Create vector that contains the treatment indicator
  email.text <- email.texts[j, 1] # Use treatment indicator to select the right text content from a pre-create email.texts dataframe. This dataframe should contain treatments texts in one column and corresponding subject lines in another.
  email.subject <- email.texts[j, 2] # Use treatment indicator to select the right subject line
  k <- as.vector(data$alias[i]) # Create vector that contains the sender indicator. We have this line here because we used ~70 different sender identities for the experiment in Butler and Crabtree (2017).
  sender <- as.vector(alias$senderemail[k]) # Use sender indicator to select the right sender email
  salutation <- "Dear" # Set salutation. This is kept constant here, but you could draw the from a vector of salutations.
  sender.name <- as.vector(alias$sendername[k]) # User sender indicator to select the identity
  email.body <- paste(salutation," ", title, " ", recipient.name, ",", email.text, sender.name, sep="") # Knit together several created vectors into an email message
  user <- as.vector(alias$senderemail[k]) # Use sender indicator to select the right email user name
  password <- as.vector(alias$password[k]) # Use sender indicator to select the right email password

  ## testing
  recipient <- "crabtreedcharles@gmail.com" # As recommend in Crabtree (2018), send the emails to yourself (and other study members) first
  
  ## implementation
  # recipient <- as.vector(dat.one$email[m]) # Create vector that contains the email address for an observation
  
  ### This is the bit that actually sends the emails
  email <- send.mail(from = sender, # Assign the sender email address
                     to = recipient, # Assign the recipient email address
                     body = email.body, # Assign the email body
                     subject = email.subject, # Assign the subject line
                     encoding = "utf-8", # Set encoding. Unless you are sending this in other languages, utf-8 should work
                     authenticate = TRUE, # Set authentication. Almost always set to TRUE.
                     send = TRUE, # Set emails to actually be sent
                     smtp = list(host.name = "smtp.gmail.com", # Set login details in this block
                                 port = 587,
                                 user.name = sender,
                                 passwd = password,
                                 tls = TRUE))
  
  cat(m, sender, "\n") # Print iteration
}
