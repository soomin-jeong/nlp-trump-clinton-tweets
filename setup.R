
# setting the working directory and loading packages
setwd('/Users/JeongSooMin/Documents/workspace/nlp-trump-clinton-tweets')

install.packages(c("tidyverse", 
                   "stringr", 
                   "tm", 
                   "wordcloud", 
                   "tidytext", 
                   "openNLP", 
                   "NLP", 
                   "rJava", 
                   "textdata",
                   "dplyr",
                   "ggplot2",
                   "scales",
                   "plyr",
                   "textcat"
                   ))

install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at")
