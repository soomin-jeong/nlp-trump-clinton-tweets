
# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

library(plyr)

raw_data = get_raw_data()
summary(raw_data)

# how many tweets did they make?
count(raw_data, "user")

# how many retweets did they get?
aggregate(raw_data$retweet_count, by=list(handle=raw_data$user), FUN=sum)

# which tweets got the most retweets for each candidate?
tweet_clinton = get_clinton_tweets()
tweet_trump = get_trump_tweets()

most_retweeted <- function(tweets, count=10){
  tweets <- tweets[order(tweets$retweet_count, decreasing=FALSE),]
  return (head(tweets$text, count))
}

most_retweeted_clinton = most_retweeted(tweet_clinton)
most_retweeted_trump = most_retweeted(tweet_trump)