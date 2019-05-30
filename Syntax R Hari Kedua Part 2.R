#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KEDUA_Selasa 21 Mei 2019 (Part 2)

#IMPORT LIBRARY YG DIBUTUHKAN
library(tm)
library(wordcloud)


#=============================================================
#=============================================================
#=============================================================
#WORD CLOUD
#=============================================================
#=============================================================
#=============================================================


#LOAD DATA YANG AKAN DI ANALISA
setwd("C:\\labs\\files")

#manual file user: 
#reviews<-read.csv(file.choose(), stringsAsFactors = FALSE)

reviews<-read.csv("reviews.csv", stringsAsFactors = FALSE)
#print(reviews)

#GABUNGKAN SEMUA REVIEW MENJADI 1 ARTIKEL BESAR
review_text<-paste(reviews$text,collapse = " ")
#print(review_text)

#CONVERT TEXT YANG AKAN DIANALISA,MENJADI DOKUMEN (CORPUS)
#CORPUS: variabel yang isinya me-representasikan sebuah dokumen
review_source<-VectorSource(review_text)
corpus<-Corpus(review_source)
print(corpus)

#LAKUKAN CLEANING
#1. Semua text diubah menjadi lower case
corpus<-tm_map(corpus, content_transformer(tolower))
#2. Semua spesial character dibuang
corpus<-tm_map(corpus, content_transformer(removePunctuation))
#3. Semua excessive whitespace (spasi/enter) di buang
corpus<-tm_map(corpus, content_transformer(stripWhitespace))
#4. Semua kata yang menyerupai "keyword" dibuang
corpus<-tm_map(corpus, removeWords, stopwords("english"))

#DOKUMENT HARUS DICONVERT MENJADI MATRIX SEBELUM DI MINNING
dtm<-DocumentTermMatrix(corpus)
dtm2<-as.matrix(dtm)
print(dtm2)

#FINDING THE MOST FREQUENT TERM
frequency<-colSums(dtm2)
frequency<-sort(frequency,decreasing=TRUE)

head(frequency)                

#AMBIL "NAMA KATA" DARI MATRIX
words<-names(frequency)
wordcloud(words[1:100], frequency[1:100])


#=============================================================
#=============================================================
#=============================================================
#ANALISIS SENTIMEN
#=============================================================
#=============================================================
#=============================================================

#BACA FILE CSV
apple<-read.csv(file.choose())
str(apple)

#IMPORT LIBRARY YG DIBUTUHKAN
library(tm)

#UBAH STRING DI DALAM DATAFRAME MENJADI CORPUS
corpus<-apple$text
corpus<-Corpus(VectorSource(corpus))

#INSPEKSI ISI CORPUS
#inspect bukan library standart R
#dia merupakan bagian dari library "tm"
#digunakan untuk melihat isi dari objek "corpus"
inspect(corpus[1:5])

#LAKUKAN PROSES CLEANSING
#1. Semua text diubah menjadi lower case
corpus<-tm_map(corpus,tolower)
inspect(corpus[1:5])
#2. Semua spesial character dibuang
corpus<-tm_map(corpus,removePunctuation)
inspect(corpus[1:5])
#3. Semua angka di buang
corpus<-tm_map(corpus,removeNumbers)
inspect(corpus[1:5])
#4. Semua stopword dibuang
cleanset<-tm_map(corpus,removeWords,stopwords("english"))
inspect(corpus[1:5])
#5. Semua http di buang
#cara 1: removeURL<-function(x)gsub('http[[:alnum:]]*','',x)

removeURL<-function(x)
{
  gsub('http[[:alnum:]]*','',x)
}

cleanset<-tm_map(cleanset,content_transformer(removeURL))
inspect(cleanset[1:5])

#6. Membuang beberapa kata yang tidak diinginkan
cleanset<-tm_map(cleanset,removeWords,c('aapl','apple'))
#7. Mereplace
cleanset<-tm_map(cleanset,gsub,pattern='stocks',replacement='stock')
#8. Membuang excessive space
cleanset<-tm_map(cleanset,stripWhitespace)
inspect(cleanset[1:5])

#selesai melakukan cleaning analisis sentimen
#sekarang wordcloudnya

#DOKUMENT HARUS DICONVERT MENJADI MATRIX SEBELUM DI MINNING
#dtm<-DocumentTermMatrix(cleanset)
dtm<-TermDocumentMatrix(cleanset)
dtm2<-as.matrix(dtm)
print(dtm2)

#FINDING THE MOST FREQUENT TERM
frequency<-colSums(dtm2)
frequency<-sort(frequency,decreasing=TRUE)

head(frequency)                

#AMBIL "NAMA KATA" DARI MATRIX
words<-names(frequency)
wordcloud(words[1:100], frequency[1:100])    

#MENAMPILKAN BAR PLOT DARI DATA YG SUDAH DICLEANSING
w<-rowSums(dtm2)
w<-subset (w,w>=25)
barplot(w,las=2,col=rainbow(50))

install.packages("wordcloud2")
library(wordcloud2)
w<-data.frame(names(w),w)
colnames(w)<-c('word','freq')

wordcloud2(w,size=0.7,shape='triangle',rotateRatio=0.5,minSize=1)

letterCloud(w,word="apple",size=1)

#IMPORT SEMUA LIBRARY YG DIBUTUHKAN UNTUK SENTIMENT YG DIBUTUHKAN
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

#READ FILE

apple<-read.csv(file.choose())

#ICONV: mengubah character set
tweets<-iconv(apple$text)

#ambil score sentiment
s<-get_nrc_sentiment(tweets)
#head(s)

barplot(colSums(s),
         las=2,
         col=rainbow(10),
         ylab='count',
        main='Skor Sentiment untuk produk Apple')


