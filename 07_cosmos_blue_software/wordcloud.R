install.packages("wordcloud")
library(wordcloud)

word = c("LILO","BIRO","SCOOBY","LOKI","WENDY","DILMINHA","PELOTAS","BIT")
freq = c(2,3,7,3,1,4,3,1)

x = data.frame(word=word,freq=freq)

wordcloud(words=word,freq=freq)

