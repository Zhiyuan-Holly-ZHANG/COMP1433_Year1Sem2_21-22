# Clear the environment:
rm(list = ls())

# Question 2. (a)
library(readr)
tweets <- read.csv("train_tweets_new.txt", header = FALSE, sep = "\t")
names(tweets) <- c("tweetID", "userID", "sentiment", "text")

# tweetID<-tweets[,1]
# userID<-tweets[,2]
# sentiment<-tweets[,3]
# text<-tweets[,4]
# n<-nrow(text)



# Question 2. (b)
library(tokenizers)
# tokens<-tweets$text
tokens <- tokenize_words(tweets$text)
tweets$tokens <- tokens



# Question 2. (c)

# more_than_3<-table(unlist(tokens))

# Create a vector that contains all unique tokens in EACH tweet:
vocab <- sapply(tweets$tokens, unique)
vocab <- unlist(vocab)
more_than_3 <- table(vocab)

the_number_of_tokens_in_vocab=length(more_than_3[more_than_3 > 3])
the_number_of_tokens_in_vocab

vocab <- names(more_than_3[more_than_3 > 3])




# Question 2. (d)
library(plyr)
# Split the tweets into three types: negative, neutral, positive:
three_sen_groups <- split(tweets, tweets$sentiment)

positive1 <- data.frame(three_sen_groups['positive'])
negative1 <-data.frame(three_sen_groups['negative'])
neutral1 <-data.frame(three_sen_groups['neutral'])

# Get each frequency:

a = count(tweets$sentiment)
a = unlist(a$freq)
p_n=a[[1]]/nrow(tweets)
p_neu=a[[2]]/nrow(tweets)
p_p=a[[3]]/nrow(tweets)

# Duplicate:
my_vocab <- vocab

word_table <- list()
word_number <- list()

# My thoughts: 
# Divide each word in my_vocab into three categories: positive, negative, and neutral 
# Determine its emotional level according to the provided database
# Divide the given sentences into words
# Add up the emotional level

library(RSentiment)

ti <- "I love the banner that was unfurled in the United end last night. It read:Chelsea - Standing up against racism since Sunday"
tii <- "So Clattenburg’s alleged racism may mean end of his career; Terry, Suarez, Rio use it and can’t play for a couple of weeks?"
tiii <- "In our busy lives in Dubai could we just spare a moment of silence this Friday morning for the people who still wear crocs."

ti<-sapply(ti, unique)
tii<-sapply(tii, unique)
tiii<-sapply(tiii, unique)


# t1 <- get_nrc_sentiment(ti)
# t2 <- get_nrc_sentiment(tii)
# t3 <- get_nrc_sentiment(tiii)
cal=calculate_sentiment(c(ti,tii,tiii))

print(paste("d<i>: ", cal[[2]][1]))
print(paste("d<ii>: ", cal[[2]][2]))
print(paste("d<iii>: ", cal[[2]][3]))



























