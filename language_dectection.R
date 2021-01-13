source('preprocess_data.R')
source('descriptive_analysis.R')

library(textcat)
library(plyr)

get_languages <- function(tweets){
  languages = textcat(tweets$text, p = ECIMCI_profiles)
  return(languages)
}

detect_lang_and_create_df <- function(tweets){
  lang = get_languages(tweets)
  tweets$lang = lang 
  return (tweets)
}

lang_clinton <- get_clinton_tweets(include_empty_twt = FALSE) %>% detect_lang_and_create_df()
lang_trump <- get_trump_tweets(include_empty_twt = FALSE) %>% detect_lang_and_create_df()
lang_clinton_cnt = table(lang_clinton$lang)
lang_trump_cnt = table(lang_trump$lang)

lang_clinton_cnt
lang_trump_cnt

# What Spanish tweets did Clinton make?
filter(tweets_clinton, lang=='es')$text

# What Spanish tweets did Trump make?
filter(tweets_trump, lang=='es')$text

# How many retweets did thet get in each language?
rtw_table_clinton = aggregate(tweets_clinton$retweet_count, by=list(tweets_clinton$lang), FUN=sum)
rtw_table_trump = aggregate(tweets_trump$retweet_count, by=list(tweets_trump$lang), FUN=sum)

# What were the languages of their most retweeted tweets?
rt100_clinton = detect_lang_and_create_df(head(most_retweeted_clinton, 100))
table(rt100_clinton$lang)
rt100_trump = detect_lang_and_create_df(head(most_retweeted_trump, 100))
table(rt100_trump$lang)
