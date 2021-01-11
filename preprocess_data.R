
# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')

# loading the dataset
raw_data = read.csv("data/tweets.csv", header=TRUE, stringsAsFactors = FALSE)
names(raw_data)[names(raw_data) == "handle"] <- "user"

NAME_TRUMP = "realDonaldTrump"
NAME_CLINTON = "HillaryClinton"

tweets_trump = filter(raw_data, user == NAME_TRUMP)
tweets_clinton = filter(raw_data, user == NAME_CLINTON)

preprocess_tweets <- function(tweets){
  tweets$text <- gsub("https\\S*", "", tweets$text) # remove hyperlinks
  tweets$text <- gsub("@\\S*", "", tweets$text) # remove mentioning other accounts
  tweets$text <- gsub("amp", "", tweets$text) # remove special characters
  tweets$text <- gsub("[\r\n]", "", tweets$text) #remove carriage return and line feed
  tweets$text <- gsub("[[:punct:]]", " ", tweets$text) # remove punctuation character like ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
  return(tweets)
}

get_raw_data <- function(){
  return(raw_data)
}

get_all_tweets <- function(include_rtw=TRUE){
  if(include_rtw == FALSE){
    return(filter(tweets, is_retweet == FALSE))}
  return(tweets)
}

get_trump_tweets <- function(include_rtw=TRUE){
  if(include_rtw == FALSE){
    tweets_trump = filter(tweets_trump, is_retweet == FALSE)
  }
  tweets_trump = preprocess_tweets(tweets_trump)
  return(tweets_trump)
}

get_clinton_tweets <- function(include_rtw=TRUE){
  if(include_rtw == FALSE){
    tweets_clinton = filter(tweets_clinton, is_retweet == FALSE)}
  tweets_clinton = preprocess_tweets(tweets_clinton)
  return(tweets_clinton)
}
