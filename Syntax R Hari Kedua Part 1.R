#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KEDUA_Selasa 21 Mei 2019 (Part 1)

#****************************************************************
#================================================================
#================================================================
#1. SUPERVISED ML
#================================================================
#================================================================
#****************************************************************


#****************************************************************
#****************************************************************
#A. REGRESION ANALYSIS
#****************************************************************
#****************************************************************

#****************************************************************
#-LINEAR REGRESSION
#****************************************************************


tinggi<-c(151,174,138,186,128,136,179,163,152,131)
berat<-c(63,81,56,91,47,57,76,72,62,48)

#meminta lm (linear model LM algorithm)
#Untuk mempelajari data kita
relation<-lm(berat~tinggi)
print(relation)

print(summary(relation))

#Memprediksi satu nilai
amir<-data.frame(tinggi=170)
berat.amir<-predict(relation,amir)
print((berat.amir))

#Memprediksi beberapa nilai
amir.budi<-data.frame(tinggi=c(170,160))
berat.amir.budi<-predict(relation,amir.budi)
print((berat.amir.budi))

#COntoh data banyak

#tinggi,berat
#151,63
#174,81
#138,56
#128,47
#132,45

setwd("D:/Pelatihan Machine Learning/Rlabs")
#Atau menggunakan datacsv<-read.csv("D://Pelatihan Machine Learning//Rlabs//tinggi_berat.csv")

#membaca dari file csv
datacsv<-read.csv("tinggi_berat.csv")
#untuk mempelajari data kita
relation<-lm(berat~tinggi, data=datacsv)

#Memprediksi beberapa nilai
amir.budi<-data.frame(tinggi=c(170,160))
berat.amir.budi<-predict(relation,amir.budi)
print((berat.amir.budi))


install.packages("rjson")
library("rjson")

datajson<-fromJSON(file="tinggi_berat.json")

relation<-lm(berat~tinggi,data=datajson)
#Memprediksi satu nilai
amir<-data.frame(tinggi=170)
berat.amir<-predict(relation,amir)
print((berat.amir))

#****************************************************************
#-MULTIPLE REGRESSION
#****************************************************************

mtcars

input<-mtcars[,c("mpg","disp","hp","wt")]
#input<-mtcars[1,1:3]
print(input)

model<-lm(mpg~disp+hp+wt, data=input)
print(model)
summary(model)

xint<-coef(model)[1]
xdisp<-coef(model)[2]
xhp<-coef(model)[3]
xwt<-coef(model)[4]

print(xint)
print(xdisp)
print(xhp)
print(xwt)


#Prediksi cara 1
disp<-221
hp<-102
wt<-2.91

mpg<-37.15+(-0.0009370091)*221+(-0.031157)*102+(-3.800891)*2.91
print(mpg)

#Prediksi cara 2
cetak.data<-function(disp,hp,wt)
{
  mpg<-37.15+(-0.0009370091)*disp+(-0.031157)*hp+(-3.800891)*wt
  print(mpg)
}

cetak.data(221,102,2.91)

#****************************************************************
#****************************************************************
#TEXT MINNING
#****************************************************************
#****************************************************************

data<-c("berdagang","begadang","dagangan","perdagangan")

hasil<-agrep("dagang",data,max.distance = 0.1)
print(hasil)

hasil<-agrep("dagang",data,max.distance = 0.2)
print(hasil)

hasil<-agrep("dagang",data,max.distance = 0.0)
print(hasil)

