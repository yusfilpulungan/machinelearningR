#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KEEMPAT_Kamis 23 Mei 2019 (Part 2)

#=============================================
#=============================================
#DEEP LEARNING
#=============================================
#=============================================

#Librari ini dibutuhkan untuk membaca image
library(EBImage)
#Library yang dibutuhkan untuk mengakses keras & tensorflow)
library(keras)

#Masuk ke directory yang berisi images
setwd('/home/deeplearning/stage/carsandplanes')
getwd()
#buat vektor yang berisi nama image yang akan digunakan
pics<-c('plane1.jpg','plane2.jpg','plane3.jpg','plane4.jpg','plane5.jpg','plane6.jpg',
        'car1.jpg','car2.jpg','car3.jpg','car4.jpg','car5.jpg','car6.jpg')

#buat list yang akan digunakan untuk menampung data image
mypic<-list()

#lakukan pembacaan image
for(i in 1:12){mypic[[i]]<-readImage(pics[i])}
print(mypic[[1]])

display(mypic[[1]])

summary(mypic[[2]])

display(mypic[[1]][,,1])
display(mypic[[1]][,,2])
display(mypic[[1]][,1,])
display(mypic[[1]][1,,])

hist(mypic[[1]])


#lakukan resize image ke lebih kecil, untuk mengurangi jumlah parameter (parameter awal 268*188*3 --> jika parameter banyak maka sejumlah iterasi itulah weight akan dihitung/learning sehingga kemungkinan laptop akan oevrload)
for(i in 1:12){mypic[[i]]<-resize(mypic[[i]],28,28)}

#lakukan inspeksi, apakah gambar sudah ter-resize
display(mypic[[1]])

#lakukan reshape agar data gambar menjadi array biasa
for(i in 1:12){mypic[[1]]<-array_reshape(mypic[[1]],c(28,28,3))}

#lakukan inspeksi, apakah array sudah berubah menjadi array biasa
print(mypic[[1]])

#lakukan konversi, agar array menjadi single dimension 
#ambil 5 gambar pesawat
trainx<-NULL
for(i in 1:5){trainx<-rbind(trainx,mypic[[i]])}

#ambil 5 gambar mobil untuk training
for(i in 7:11){trainx<-rbind(trainx,mypic[[i]])}

#ambil 1 gambar mobil & 1 gambar pesawat untuk testing
testx<-rbind(mypic[[6]],mypic[[12]])

#lakukan inspeksi, apakah array sudah menjadi single dimension
print(trainx)


#buat label untuk data training
#pesawat=0
#mobil=1
train_category<-c(0,0,0,0,0,1,1,1,1,1)

#kirim label tensorflow agar dikenal
trainLabels<-to_categorical(train_category)


#kita susun neuron untuk deeplearning
model<-keras_model_sequential()

model%>%
  layer_dense(units=256, activation="relu", input_shape=c(2352))%>%
  layer_dense(units=128, activation="relu")%>%
  layer_dense(units=2, activation='softmax')

summary(model)

#Lakukan kompilasi ke neuron model
model%>%compile(loss="binary_crossentropy", optimizer=optimizer_rmsprop(),
                metrics=c('accuracy'))

#lakukan proses learning/training
history<-model %>% fit(trainx, trainLabels, epoch=200, batch_size=10, validation_split=0.2)
#history epoch
plot(history)

#lakukan evaluasi hasil training
model %>% evaluate(trainx,trainLabels)

##lakukan prediksi terhadap test data, menggunakan model yang telah kita training
pred<-model %>% predict(testx)

#melihat hasil prediksi
pred[1]
pred[2]
print(pred)


#=============================================
#=============================================
#KONVOLUTION
#=============================================
#=============================================


#LOAD LIBRARY YG DIBUTUHKAN
library(keras)
library(EBImage)

#MASUK KE FOLDER LOKASI IMAGE BERADA
setwd('/home/deeplearning/stage/vehicles')

#BUAT VECTOR YG BERISI NAMA2 FILE IMAGE
pic1<-c('p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg',
        'c1.jpg','c2.jpg','c3.jpg','c4.jpg','c5.jpg',
        'b1.jpg','b2.jpg','b3.jpg','b4.jpg','b5.jpg')

#BACA IMAGE DARI FOLDER	, dan GUNAKAN SEBAGAI DATA TRAINING
train<-list()
for(i in 1:15){train[[i]]<-readImage(pic1[i])}	

#SIAPKAN DATA TEST
pic2<-c('p6.jpg','c6.jpg','b6.jpg')
test<-list()
for(i in 1:3){test[[i]]<-readImage(pic2[i])}

#EXPLORE DATA IMAGE (OPTIONAL)
print(train[[2]])
summary(train[[2]])
display(train[[2]])
plot(train[[2]])

#MENAMPILKAN PLOT BEBERAPA IMAGE SEKALIGUS
par(mfrow=c(3,5))
for(i in 1:15)plot(train[[i]])

#RESIZE & COMBINE
for(i in 1:15){train[[i]]<-resize(train[[i]],100,100)}
for(i in 1:3){test[[i]]<-resize(test[[i]],100,100)}

train<-combine(train)
x<-tile(train,5)
display(x,title='MyImage')

test<-combine(test)
y<-tile(test,3)
display(y,title='Test')

#KHUSUS CNN, HARUS MENJALANKAN STEP BERIKUT
train<-aperm(train,c(4,1,2,3))
test<-aperm(test,c(4,1,2,3))

#SIAPKAN LABEL UNTUK DATA TRAINING
#0=PESAWAT
#1=MOBIL
#2=SEPEDA
trainy<-c(0,0,0,0,0,1,1,1,1,1,2,2,2,2,2)

#register label ke tensorflow
trainLabels<-to_categorical(trainy)

#SUSUN NEURON, SEPERTI YG TELAH DI DESAIN
model<-keras_model_sequential()

model %>%
  layer_conv_2d(filters=32, kernel_size=c(3,3),activation='relu', input_shape=c(100,100,3))%>%
  layer_conv_2d(filters=32,kernel_size=c(3,3),activation='relu' )%>%
  layer_max_pooling_2d(pool_size=c(2,2))%>%
  layer_dropout(rate=0.25) %>%
  layer_conv_2d(filters=64, kernel_size=c(3,3),activation='relu')%>%
  layer_conv_2d(filters=64, kernel_size=c(3,3),activation='relu')%>%
  layer_max_pooling_2d(pool_size=c(2,2))%>%
  layer_dropout(rate=0.25) %>%
  layer_flatten() %>%
  layer_dense(units=256,activation='relu')%>%
  layer_dropout(rate=0.25) %>%
  layer_dense(units=3,activation='softmax')



model %>% compile(loss='categorical_crossentropy',optimizer=optimizer_rmsprop(),metrics=c('accuracy'))

history<-model %>% fit(train, trainLabels,epoch=200,batch_size=32,validation_split=0.2)

model%>%evaluate(train,trainLabels)


pred<-model %>% predict(test)
pred[1]
pred[2]
pred[3]