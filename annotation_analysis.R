# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')
source('preprocess_data.R')

# install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at")

library(rJava)

# configured the memory up to 12G
.jinit(parameters="-Xmx15g")
library(openNLP)
library(NLP)
library(openNLPmodels.en)
library(tm)

trump_tweets = head(get_trump_tweets()$text, 50)
file_name = paste(getwd(), '/data', '/docs', '/trump_tweets.csv', sep = '')
write(trump_tweets, file=file_name, append = FALSE)

source.pos = DirSource("data/docs", encoding = "UTF-8")
corpus = Corpus(source.pos)
inspect(corpus[[1]])

gc()

getAnnotationsFromDocument = function(doc){
  x=as.String(doc)
  sent_token_annotator <- Maxent_Sent_Token_Annotator()
  word_token_annotator <- Maxent_Word_Token_Annotator()
  pos_tag_annotator <- Maxent_POS_Tag_Annotator()
  y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
  y2 <- annotate(x, pos_tag_annotator, y1)
  parse_annotator <- Parse_Annotator()
  y3 <- annotate(x, parse_annotator, y2)
  return(y3)  
} 

getAnnotatedPlainTextDocument = function(doc,annotations){
  x=as.String(doc)
  a = AnnotatedPlainTextDocument(x,annotations)
  return(a)  
} 

getAnnotatedMergedDocument = function(doc,annotations){
  x=as.String(doc)
  y2w <- subset(annotations, type == "word")
  tags <- sapply(y2w$features, '[[', "POS")
  r1 <- sprintf("%s/%s", x[y2w], tags)
  r2 <- paste(r1, collapse = " ")
  return(r2)  
} 

annotations = lapply(corpus, getAnnotationsFromDocument)
head(annotations[[1]])

corpus.tagged = Map(getAnnotatedPlainTextDocument, corpus, annotations)
corpus.tagged[[1]]
corpus.taggedText = Map(getAnnotatedMergedDocument, corpus, annotations)
corpus.taggedText[[1]] 

doc = corpus.tagged[[1]] 
as.character(doc)

head(words(doc))
head(sents(doc), 3)
head(parsed_sents(doc),2)
