source('preprocess_data.R')

library(tm)
library(wordcloud)
library(tidytext)

# getting the preprocessed dataset
tweets_trump = get_trump_tweets(organic_twt_only = TRUE)$text
tweets_clinton = get_clinton_tweets(organic_twt_only = TRUE)$text
docs_trump <- Corpus(VectorSource(tweets_trump))
docs_clinton <- Corpus(VectorSource(tweets_clinton))

# cleaning the text in the form of Corpus (in the library 'tm')
clean_the_data <- function(docs){
  docs <- tm_map(docs, content_transformer(tolower))
  docs <- tm_map(docs, removeWords, stopwords("english"))
  return (docs)
}

cleaned_trump = clean_the_data(docs_trump)
cleaned_clinton = clean_the_data(docs_clinton)

get_word_counts <- function(cleaned_docs){
  dtm <- TermDocumentMatrix(cleaned_docs) 
  matrix <- as.matrix(dtm) 
  words <- sort(rowSums(matrix),decreasing=TRUE) 
  word_counts <- data.frame(word = names(words),freq=words)
  return(word_counts)
}

set.seed(1234)
wordcount_trump = get_word_counts(cleaned_trump)
wordcount_clinton = get_word_counts(cleaned_clinton)

wordcloud(words = wordcount_trump$word, freq = wordcount_trump$freq, min.freq = 10, max.words=100, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))
wordcloud(words = wordcount_clinton$word, freq = wordcount_clinton$freq, min.freq = 10, max.words=100, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))
