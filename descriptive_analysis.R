
# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

library(plyr)

# how many tweets did they make?
count(raw_data, "user")

# how many retweets did they get?
aggregate(raw_data$retweet_count, by=list(handle=raw_data$user), FUN=sum)

# which tweets got the most retweets for each candidate?
tweet_clinton = get_clinton_tweets() 
tweet_trump = get_trump_tweets()

most_retweeted <- function(tweets, count=10){
  tweets <- tweets[order(tweets$retweet_count, decreasing=FALSE),]
  return (tweets)
}

most_retweeted_clinton = most_retweeted(tweet_clinton)
most_retweeted_trump = most_retweeted(tweet_trump)

# which tweets got the most favorites?
most_favorite <- function(tweets, count=10){
  tweets <- tweets[order(tweets$favorite_count, decreasing=FALSE),]
  return (tweets)
}
most_favorite_clinton = most_favorite(tweet_clinton)
most_favorite_trump = most_favorite(tweet_trump)

# how many retweets did they make?
retweets_clinton = filter(tweet_clinton, is_retweet == "True")
retweets_trump = filter(tweet_trump, is_retweet == "True")

nrow(retweets_clinton)
nrow(retweets_trump)



# how many replies did they make?
replies_clinton = filter(tweet_clinton, !is.na(in_reply_to_status_id))
replies_trump = filter(tweet_trump, !is.na(in_reply_to_status_id))

nrow(replies_clinton)
nrow(replies_trump)
