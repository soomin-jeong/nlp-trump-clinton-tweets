# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

library(tm)
library(wordcloud2)

# getting the preprocessed dataset
tweets_trump = get_trump_tweets(organic_twt_only = TRUE)
tweets_clinton = get_clinton_tweets(organic_twt_only = TRUE)
docs_trump <- Corpus(VectorSource(tweets_trump))
docs_clinton <- Corpus(VectorSource(tweets_clinton))

# cleaning the text in the form of Corpus (in the library 'tm')
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


set.seed(1234)
wordcloud2(data=df, size=5, color='random-dark')
