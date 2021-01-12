# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

library(tidytext)
library(textdata)
library(dplyr)
library(ggplot2)
library(scales)

tokenize <- function(tweets){
  tokens = tweets %>%
    select(text) %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words)
  return(tokens)
}

analyze_sentiments <- function(tweets){
  tokens = tweets %>%
    select(text) %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words)
  
  sentiments = tokens %>%
    inner_join(get_sentiments("afinn")) %>%
    dplyr::count(word, value, sort=TRUE) %>%
    ungroup() 
  return(sentiments)
}

clinton_sentiments = get_clinton_tweets(organic_twt_only = TRUE) %>% 
  analyze_sentiments

trump_sentiments = get_trump_tweets(organic_twt_only = TRUE) %>% 
  analyze_sentiments

summary(trump_sentiments)

clinton_sentiment_sum = setNames(aggregate(clinton_sentiments$n, by=list(clinton_sentiments$value), FUN=sum), c("sentiment", "sum_value"))
ggplot(clinton_sentiment_sum, aes(x =sentiment, y = sum_value)) + geom_bar(stat = "identity") + 
  labs(y = "Strength",
       x = "Sentiments",
       title = "Sentiments in the Tweets",
       subtitle = " (Negative < 0 and Positive > 0)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))
  

trump_sentiment_sum = setNames(aggregate(trump_sentiments$n, by=list(trump_sentiments$value), FUN=sum), c("sentiment", "sum_value"))
ggplot(trump_sentiment_sum, aes(x =sentiment, y = sum_value)) + geom_bar(stat = "identity") +
  labs(y = "Strength",
       x = "Sentiments",
       title = "Sentiments in the Tweets",
       subtitle = " (Negative < 0 and Positive > 0)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))


