# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')
library(textcat)
library(plyr)

get_languages <- function(tweets){
  languages = textcat(tweets$text, p = ECIMCI_profiles)
  return(languages)
}

tweets_clinton <- get_clinton_tweets()
tweets_trump <- get_trump_tweets()

lang_clinton = get_languages(tweets_clinton)
lang_trump = get_languages(tweets_trump)

lang_clinton_cnt = table(lang_clinton)
lang_trump_cnt = table(lang_trump)

# What Spanish tweets did Clinton make?
tweets_clinton$text[which(lang_clinton %in% ('es'))]

# What Spanish tweets did Trump make?
tweets_trump$text[which(lang_trump %in% ('es'))]
