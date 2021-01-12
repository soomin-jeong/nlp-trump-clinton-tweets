
# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')

library(tidyverse)
library(stringr)

# loading the dataset
raw_data = read.csv("data/tweets.csv", header=TRUE, stringsAsFactors = FALSE)
summary(raw_data)
names(raw_data)[names(raw_data) == "handle"] <- "user"

NAME_TRUMP = "realDonaldTrump"
NAME_CLINTON = "HillaryClinton"

tweets_trump = filter(raw_data, user == NAME_TRUMP)
tweets_clinton = filter(raw_data, user == NAME_CLINTON)

preprocess_tweets <- function(tweets){
  tweets$text <- gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", tweets$text) # remove multiple hyperlinks
  tweets$text <- gsub("@\\S*", "", tweets$text) # remove mentioning other accounts
  tweets$text <- gsub("amp", "", tweets$text) # remove special characters
  tweets$text <- gsub("[\r\n]", "", tweets$text) #remove carriage return and line feed
  tweets$text <- gsub("[[:punct:]]", " ", tweets$text) # remove punctuation character like ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
  return(tweets)
}

get_raw_data <- function(){
  return(raw_data)
}

get_organic_tweets <- function(tweets){
  # Remove retweets
  organic_tweets <- tweets[tweets$is_retweet=='False', ] 
  # Remove replies
  organic_tweets <- subset(organic_tweets, is.na(organic_tweets$in_reply_to_user_id)) 
  return (organic_tweets)
}

get_all_tweets <- function(include_rtw=TRUE){
  if(include_rtw == FALSE){
    return(filter(raw_data, is_retweet == FALSE))}
  return(raw_data)
}

get_trump_tweets <- function(organic_twt_only=FALSE, include_empty_twt=TRUE){
  if(include_empty_twt == FALSE){
    tweets_trump = filter(tweets_trump, text != '')}
  if(organic_twt_only == TRUE){
    tweets_trump = get_organic_tweets(tweets_trump)}
  tweets_trump = preprocess_tweets(tweets_trump)
  return(tweets_trump)
}

get_clinton_tweets <- function(organic_twt_only=FALSE, include_empty_twt=TRUE){
  if(include_empty_twt == FALSE){
    tweets_clinton = filter(tweets_clinton, text != '')}
  if(organic_twt_only == TRUE){
    tweets_clinton = get_organic_tweets(tweets_clinton)}
  tweets_clinton = preprocess_tweets(tweets_clinton)
  return(tweets_clinton)
}
