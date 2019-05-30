#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KELIMA_Jumat 24 Mei 2019

#================================================================
#================================================================
#================================================================
#Pelatihan hari ke lima
#Deeplearning RNN
#================================================================
#================================================================
#================================================================



library(keras)

N=400
step=2

#GENERATE SEQUENCE NUMBER DARI 1 SAMPAI 400
n=seq(1:N)

#LAKUKAN KOMPUTASI ACAK, AGAR ANGKA MENGANDUNG PECAHAN
a=n/10+4*sin(n/10)+sample(-1:6,N,replace=T)+rnorm(N)
print(a)

#DATA a TAMBAH 2 lagi, agar jumlah element menjadi 402
a=c(a,replicate(step,tail(a,1)))

print(a)

#siapkan data yg akan digunakan untuk learning
x=NULL
y=NULL

for(i in 1:N)
{
  s=i-1+step
  x=rbind(x,a[i:s])
  y=rbind(y,a[s+1])
}

print(x)
print(y)

XX=array(x,dim=c(N,step,1))

model<-keras_model_sequential()
model %>% layer_lstm(units=128, input_shape=c(step,1),activation="relu")%>%
  layer_dense(units=64, activation="relu")%>%
  layer_dense(units=32) %>%
  layer_dense(units=1, activation="linear")

model %>% compile(loss="mse", 
                  optimizer="adam", 
                  metrics=list("mean_absolute_error")
)

model %>% summary()	

#LAKUKAN PROSES LEARNING
model %>% fit(XX,y,epochs=50,batch_size=32,shufle=FALSE,verbose=1)

#LAKUKAN PREDIKSI
y_pred=model %>% predict(XX)
print(y_pred)

#MELIHAT AKURASI PREDIKSI
scores  =  model %>% evaluate(XX, y, verbose = 1)
print(scores)

print(x)
print(y)

#MELIHAT PLOT
x_axes = seq(1:length(y_pred))
plot(x_axes, y, type="l", col="red", lwd=2)
lines(x_axes, y_pred, col="blue",lwd=2)
legend("topleft", legend=c("y-original", "y-predicted"),
       col=c("red", "blue"), lty=1,cex=0.8)




#================================================================
#================================================================
#================================================================
#Pelatihan hari ke lima
#Crowling 
#================================================================
#================================================================
#================================================================



install.packages("RCurl")
install.packages("XML")
install.packages("stringr")
install.packages("plyr")


library("RCurl")
library("XML")
library("stringr")
library("plyr")

#Buat variabel yang berisi url
url<-"http://belajaroracle.com/source/csv/"

#ambil semua hyperlink yang ada di website
links<-getHTMLLinks(url)

#sebutkan nama file yang akan diabil
filenames<-links[str_detect(links,"employees")]

#sebutkan nama file yang akan diabil mengandung huruf tertentu
filenames<-links[str_detect(links,"e")]


#sebutkan nama file sebagai list
filenames_list<-as.list(filenames)

#buat function untuk mendownload file
downloadfile<-function(mainurl,filename)
{
  filedetails<-str_c(mainurl,filename)
  download.file(filedetails,filename)
}


#siapkan lokasi download
setwd('D:\\Pelatihan Machine Learning\\Rlabs')

#lakukan download
l_ply(filenames,downloadfile,mainurl=url)



#====================================
#Buat variabel yang berisi url
url<-"https://news.detik.com/berita/"

#ambil semua hyperlink yang ada di website
links<-getHTMLLinks(url)

#sebutkan nama file yang akan diabil
filenames<-links[str_detect(links,"employees")]

#sebutkan nama file yang akan diabil mengandung huruf tertentu
filenames<-links[str_detect(links,"e")]


#sebutkan nama file sebagai list
filenames_list<-as.list(filenames)

#buat function untuk mendownload file
downloadfile<-function(mainurl,filename)
{
  filedetails<-str_c(mainurl,filename)
  download.file(filedetails,filename)
}


#siapkan lokasi download
setwd('D:\\Pelatihan Machine Learning\\Rlabs')

#lakukan download
l_ply(filenames,downloadfile,mainurl=url)




#=========================================================
#=========================================================
#=========================================================
#Visualisasi
#=========================================================
#=========================================================
#=========================================================

x<-c(22,63,11,54)
labels<-c("Jakarta","Bandung","Surabaya","Semarang")

#arahkan ke folder tujuan
#setwd("D:\\Pelatihan Machine Learning\\Rlabs")


#beri nama file
#png(file="kota.png")


pie(x,labels)

#Flush/write file to disk
#dev.off()

#pie chart dengan warna rainbow
pie(x,labels,main="Daftar Nama Kota", col=rainbow(length(x)))


#pie chart dengan piepercent
persentase<-round(100*x/sum(x),1)

pie(x, labels=persentase, main="Pie Chart Dengan Persentase", col=rainbow(length(x)))
legend("topright",labels,cex=0.8,fill=rainbow(length(x)))

install.packages("plotly")
#Kalo mau belajar: plot.ly/r/pie.chart
