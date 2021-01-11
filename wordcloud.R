# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

library(tm)
library(ggplot2)
library(wordcloud)
library(RWeka)
library(reshape2)
library(dplyr)

# getting the preprocessed dataset
tweets_trump = get_trump_tweets()
tweets_clinton = get_clinton_tweets()
docs_trump <- Corpus(VectorSource(tweets_trump))
docs_clinton <- Corpus(VectorSource(tweets_clinton))

# cleaning the text
clean_the_data <- function(docs){
  docs <- docs %>%
    tm_map(removeNumbers) %>%
    tm_map(stripWhitespace)
  docs <- tm_map(docs, content_transformer(tolower))
  docs <- tm_map(docs, removeWords, stopwords("english"))
  return (docs)
}

cleaned_trump = clean_the_data(docs_trump)
cleaned_clinton = clean_the_data(docs_clinton)

dtm <- TermDocumentMatrix(cleaned_trump) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

tweets_words <-  tweets %>%
  select(text) %>%
  unnest_tokens(word, text)
words <- tweets_words %>% count(word, sort=TRUE)


set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
