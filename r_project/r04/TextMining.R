install.packages("rJava")
install.packages("memoise")
install.packages("multilinguer")
install.packages(c("stringr","hash","tau","sejong","RSQLite","devtools"),type = "binary")
install.packages("remotes")
install.packages('wordcloud')
# install.packages("KoNLP") # 현재 CRAN에 없음

library(dplyr)
library(multilinguer)
library(rJava)
library(KoNLP)
library(stringr)
library(wordcloud)
library(RColorBrewer)

Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk1.8.0_241/jre")

remotes::install_github("haven-jeon/KoNLP", 
                        upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))

useNIADic()

.libPaths()

txt <- readLines('hiphop3.txt')

head(txt)
View(txt)


txt <- str_replace_all(txt,'\\W',' ') # 정규식 형태로 넣는다.(\t = tab, \n = enter)
txt

extractNoun('나는 파이썬 천재다. 대한민국에 살고 있다.')

nouns <- extractNoun(txt)
head(nouns)

wordCount1 <- unlist(nouns)

wordCount <- table(wordCount1)
View(wordCount)

df_word <- as.data.frame(wordCount,stringsAsFactors = F)


df_word <- rename(df_word, word=wordCount1,
                  freq=Freq)

dfword <- filter(df_word, nchar(word) >= 2)

top_20 <- dfword %>% arrange(desc(freq)) %>% head(20)


pal <- brewer.pal(8,"Dark2")
set.seed(1234)

wordcloud(words = dfword$word,
          freq = dfword$freq,
          min.freq = 1,
          max.words = 300,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)

top_20


txt2 <- readLines('한·핀란드 스타트업 서밋.txt')
txt2
nouns2 <- extractNoun(txt2)
nouns2
wordcounts1 <- unlist(nouns2)
View(wordcounts1)
wordcounts <- table(wordcounts1)
table(wordcounts)
df_word2 <- as.data.frame(wordcounts, stringsAsFactors = F)
df_word2 <- filter(df_word2,nchar(wordcounts1)>=2)
wordcloud(words = df_word2$wordcounts1,
          freq = df_word2$Freq,
          min.freq = 3,
          max.words = 200,
          random.order = F,
          rot.per = 0.2,
          scale = c(4,0.6),
          colors = pal)

txt3 <- readLines('economy.txt')
nouns3 <- extractNoun(txt3)
nouns3
wordcount3 <- unlist(nouns3)
wordcounts3 <- table(wordcount3)
table(wordcounts3)
df_word3 <- as.data.frame(wordcounts3,stringsAsFactors = F)
df_word3 <- filter(df_word3,nchar(wordcount3)>=2)
wordcloud(words = df_word3$wordcount3,
          freq = df_word3$Freq,
          min.freq = 4,
          max.words = 300,
          random.order = F,
          rot.per = 0.3,
          scale = c(4,0.5),
          colors = pal)
