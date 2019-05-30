#PELATIHAN MACHINE LEARNING_LATIHAN R HARI PERTAMA_Senin 20 Mei 2019

print("hello R..")
salam<-"Hallo R lagi"
print(salam)


print("Ini dicetak dari script")
myvar<-"Ini string lagi"
print(myvar)

#VARIABLES
#-Lokasi di memory, punya nama, yang kita pesan untuk menyimpan data yang isinya bisa diubah2
#-Di dalam R, variabel bersifat "type less" artinya type data dari variabel tersebut TIDAK PERLU di deklarasikan, ketika membuat variabel


#TYPE VARIABEL
#================================================================
#-Sebuah variabel bisa diisi dengan beberapa tipe data saja, type data yang boleh diisi ke dalam R Variabel: yaitu
#   a. Logikal -> hanya memuat dua value = TRUE atau FALSE
#   b. numeric -> menyimpan data numerik bisa point decimal
#   c. integer -> menyimpan bilangan bulat
#   d. complex -> menyimpan bilangan komplek
#   e. character -> menyimpan deretan karakter
#   f. Raw -> menyimpan bilangan hexadesimal

# untuk quit: q()

kata<-"jakarta"
print(kata)

benar<-TRUE
print(class(benar))

angka<-123.45
print(class(angka))

bulat<-1000L
print(class(bulat))

kompleks<-5+3i
print(class(kompleks))

kata<-"Jakarta"
print(class(kata))

huruf="abc"
print(huruf)

print(bulat)
"def"->test

print(test)


myraw<-charToRaw("Jakarta")
print(class(myraw))

#JENIS VARIABEL
#================================================================
#a. SCALAR Variabel
#     Variabel yang hanya memuat 1 nilai/value
#b. VECTOR Variabel
#     Variabel yang bisa memuat banyak nilai/value
#        *Yang termasuk Vekrtor
#        1. Vektor
#        2. List
#        3. Matrix
#        4. array
#        5. Data Frame

#================================================================
#================================================================
#================================================================
#1. VEKTOR
#Variabel yang berisi deretan value, baik numerik, logical, char, mauoun type lain
#c()
#================================================================
#================================================================
#================================================================
#MENGGUNAKAN 1 VEKTOR
#mencetak semua element didalam vektor
buah<-c("apel","nanas","mangga")
print(buah)

deret<-5:13
print(deret)

deret.pecahan<-6.6:12.6
print(deret.pecahan)

deret.pecahan2<-6.8:12.3
print(deret.pecahan2)

#kalo bikin var dua kata maka disarankan pake titik
#vektor defaulnya selslu naik satu
#R case sensitif
#bikin yang manual naik sesuai kebutuhan
print(seq(5,9, by=0.4))

#didalam vektor indeks terendah adalah 1 bukan nol
#mencetak semua element didalam vektor
#================================================================
print(buah)

#mencetak satu element didalam vektor
#================================================================
print(buah[1])

#mencetak beberapa element didalam vektor
#================================================================
print(buah[c(2,3)])

#mencetak menggunakan logical indexing
#================================================================
print(buah[c(TRUE,TRUE,FALSE)])

#mencetak menggunakan binary indexing
#================================================================
#print(buah[c(0,1,1)])


#================================================================
#MENGGUNAKAN 2 VEKTOR ELEMEN SAMA
#Hindari melakukan aritmatika pada 2 vektor yang beda jumlah
v1<-c(3,8,4,5,0,11)
v2<-c(4,11,0,8,1,2)

hasil.jumlah<-v1+v2
print(hasil.jumlah)
hasil.kurang<-v1-v2
print(hasil.kurang)
hasil.kali<-v1*v2
print(hasil.kali)
hasil.bagi<-v1/v2
print(hasil.bagi)

#mengetahui jumlah element vektor
print(length(hasil.bagi))

#Mengurutkan vektor elemen bilangan ascending dan descending 
v<-c(3,8,4,5,0,11,2)
print(v)

v.urut<-sort(v)
print(v.urut)

v.urut.terbalik<-sort(v, decreasing = TRUE)
print(v.urut.terbalik)

#Mengurutkan vektor character character ascending dan descending 
warna<-c("red", "blue", "yellow", "green")
print(warna)

warna.urut<-sort(warna)
print(warna.urut)

warna.urut.terbalik<-sort(warna, decreasing = TRUE)
print(warna.urut.terbalik)


#================================================================
#================================================================
#================================================================
#2. LIST
#variabel yang berisi variable scalar, maupun variabel vektor lain (bercampur antara skalar dengan vektor dalam 1 variabel)
#list()
#Tidak bisa digunakan untuk operasi aritmatik harus dikonvert menjadi vektor
#================================================================
#================================================================
#================================================================
#Mencetak semua isi list
list.data<-list("merah", "biru", c(21,31,11), TRUE, 11.2)
print(list.data)

#Mencetak isi list pada elemen tertentu
print(list.data[[1]])

#Mencetak isi list pada elemen tertentu
print(list.data[[1]])

#untuk mencetak list maka kurungnya dua, untuk mencetak vektor kurung 1
#Mencetak isi list pada elemen tertentu yang berisi vector pada element tertentu *print
print(list.data[[3]][2])
#Mencetak isi list pada elemen tertentu yang berisi vector pada element tertentu dengan tambahan deskripsi isian *paste
paste("Isi elemen 2 pada vektor:",list.data[[3]][2])

#================================================================
#Contoh list yang berisi bermacam2 vektor variabel
list.data<-list(c("jan","feb","Mar"), matrix(c(3,9,5,1,-2,8), nrow=2),list("green",12.3))
print(list.data)
print(list.data[[3]][1])

#Contoh memberikan nama index pada element list
names(list.data)<-c("Sebuah vektor", "Sebuah matrix", "List lagi")
print(list.data)

#Mengakses elemen list yang sudah diberi nama 
print(list.data$`Sebuah vektor`)
print(list.data$`Sebuah vektor`[2])

#================================================================
#MERGE LIST (Menggabungkan 2 list)
list1<-list(1,2,3)
list2<-list("SENIN","SELASA","RABU")

list.gabungan<-c(list1,list2)
print(list.gabungan)

#================================================================
#MERUBAH LIST MENJADI VEKTOR
list1<-list(1:5)
print(list1)

list2<-list(10:14)
print(list2)

v1<-unlist(list1)
v2<-unlist(list2)

hasil.jumlah<-v1+v2
print(hasil.jumlah)

#================================================================
#================================================================
#================================================================
#3. MATRIX
#Mirip seperti vektor, tetapi tersusun menjadi baris dan kolom
#matrix()
#================================================================
#================================================================
#================================================================
#Mencetak semua elemen matrik
m<-matrix(c(3:14), nrow = 4)
print(m)

#Mencetak row tertentu
print(m[1,])

#Mencetak kolom tertentu
print(m[,2])

#Mencetak baris dan kolom tertentu
print(m[1,2])

#Matriks defaultnya tersusun kebawah
m<-matrix(c(3:14), nrow = 4)
#Mengubahnya defaultnya tersusun kesamping
m<-matrix(c(3:14), nrow = 4, byrow = TRUE)
print(m)

#Mengubah nama baris dan kolom pada output
rownames<-c("row1","row2","row3","row4")
colnames<-c("col1","col2","col3")

m2<-matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames= list(rownames,colnames))
print(m2)

#Cetak baris ke 1
print(m2["row1",])

#Cetak baris ke 2
print(m2[,"col2"])

#Cetak baris 2 kolom 2
print(m2["row2","col2"])

matrix1<-matrix(c(3,9,-1,4,2,6), nrow = 2)
matrix2<-matrix(c(5,2,0,9,3,4), nrow = 2)

matrix.jumlah<-matrix1+matrix2
print(matrix.jumlah)

matrix.kurang<-matrix1-matrix2
print(matrix.kurang)

matrix.kali<-matrix1*matrix2
print(matrix.kali)

matrix.bagi<-matrix1/matrix2
print(matrix.bagi)


#================================================================
#================================================================
#================================================================
#4. ARRAY
#Adalah "array of matrix", atau sebuah variabel yang bisa memuat banyak matrix dengan dimensi/ordo yang sama. 
#contoh penggunaannya adalah menyimpan image dalam 1 variabel
#================================================================
#================================================================
#================================================================
vektor1<-c(5,9,3)
vektor2<-c(10,11,12,13,14,15)

#result<-array(c(vektor1,vektor2), dim = c(3->baris,1->kolom,3->buah))
result<-array(c(vektor1,vektor2), dim = c(3,1,3))
print(result)


#result<-array(c(vektor1,vektor2), dim = c(3->baris,3->kolom,2->buah))
result<-array(c(vektor1,vektor2), dim = c(3,3,2))

#Mencetak semua matrix di dalam array
print(result)

#Mencetak matrix pertama dalam sebuah array
print(result[,,1])

#Mencetak matrix pertama kolom ke dua dalam sebuah array
print(result[,2,1])

#Mencetak matrix pertama baris ke dua kolom ke tiga dalam sebuah array
print(result[2,3,1])

#Mengubah nama baris dan kolom pada output
row.names<-c("row1","row2","row3")
column.names<-c("col1","col2","col3")
matrix.names<-c("matrix1","matrix2")

result<-array(c(vektor1,vektor2), dim=c(3,3,2), dimnames = list(row.names,column.names,matrix.names))
print(result)
print(result[,"col3","matrix1"])

#cara ektract matrix dari sebuah array
matrix1<-result[,,"matrix1"]
matrix2<-result[,,"matrix2"]

hasil.jumlah<-matrix1+matrix2
print(hasil.jumlah)



#================================================================
#================================================================
#================================================================
#5. DATA FRAME
#adalah vektor variabel yang "mirip" seperti table di dalam database. Ini biasanya digunakan untuk menampung data yang diambil dari database/csv/xml/json
#mirip data di spss
#================================================================
#================================================================
#================================================================

emp.data<-data.frame(
  nip=c(100:104),
  nama=c("amir","budi","charli","dedi","eri"),
  gaji=c(1000,2000,3000,4000,5000)
)

#Mencetak semua data frame
print(emp.data)

#Mencetak kolom tertentu sebuah data frame
print(emp.data$nip)

#Melihat struktur dataframe
str(emp.data)

#Melihat summary dataframe
print(summary(emp.data))

#Membuat data frame baru dengan cara mengektrak sebagian kolom
baru<-data.frame(emp.data$nip, emp.data$gaji)
print(baru)


#========================================================
#MENAMBAHKAN VARIABEL

baru$divisi<-c("finance","hard","security","exec","boss")
print(baru)

print(emp.data[1,,])
print(emp.data[,1,])


#========================================================
#MENAMBAHKAN CASES

emp.data<-data.frame(
  nip=c(100:104),
  nama=c("amir","budi","charli","dedi","eri"),
  gaji=c(1000,2000,3000,4000,5000)
)

emp.data.baru<-data.frame(
  nip=c(105:107),
  nama=c("fikri","geri","heri"),
  gaji=c(6000,7000,8000)
)

#Contoh menggabungkan 2 buah data frame
emp.gabungan<-rbind(emp.data,emp.data.baru)
print(emp.gabungan)



#================================================================
#================================================================
#================================================================
#6. FAKTOR
#adalah vektor variabel yang menyimpan hierarki dari sebuah value
#================================================================
#================================================================
#================================================================

data<-c("east","east","east","west","nort","nort","nort","south")
print(data)

print(is.factor(data))
faktorku<-factor(data)

print(faktorku)
print(is.factor(faktorku))



#****************************************************************
#================================================================
#================================================================
#FUNCTION

#- Sering disebut dengan sub-program
#- atau juga disebut sebagai prosedure/method
#- Definisi: block kode, punya nama, bisa dipanggil berulang2 untuk menjalankan spesifik task
#================================================================
#================================================================
#****************************************************************

#JENIS FUNCTION ADA 2
#a. Void function (A.K.A: procedure(pascal/basic/oracle plsql, etc))
#  -adalah function yang ketika dipanggil, dia hanya sekedar jalan, maksudnya, setelah selesai jalan, dia tidak mereturn sebuah value
#b. non-void function (A.K.A: function yang ketika dipanggil, disamping menjalankan task, setelash selesai dia akan meretur sebuah value, yang bisa ditangkap dari luar)


#VOID FUNCTION
#=====================================

#Deklarasi Function
cetak.data<-function(nip,nama,alamat)
{
  print(paste("NIP:", nip))
  print(paste("NAMA:", nama))
  print(paste("ALAMAT:", alamat))
  print("==============")
}

#Memanggil function dengan parameter urut seperti definisi
cetak.data(100,"amir","Jl dr. Sutomo")
cetak.data(200,"Budi","Jl dr. Charles")

#Memanggil function tidak urut, tetapi menyebutkan parameternya
cetak.data(alamat="Slipi",nama="ciko",nip=102)
cetak.data(alamat="Menteng",nip=103,nama="damar")



#NON VOID FUNCTION
#=====================================
#contoh 1

kalikan<-function(a,b,c)
{
  hasil<-a*b*c
  return(hasil)
}

#cara panggil
hasil.kali<-kalikan(9,8,10)
print(hasil.kali)

#cara panggil 2
print(kalikan(9,8,10))

#=====================================
#contoh 2

seven<-function()
{
  x=7
  return(x)
}

sepuluh<-function()
{
  y=10
  return(y)
}

kalih<-function()
{
  z=2
  return(z)
}

print(kalikan(seven(),sepuluh(),kalih()))

#=====================================
#contoh 3

cetak.data<-function(nip=100,nama="amir",alamat="jakarta")
{
  print(paste("NIP:", nip))
  print(paste("NAMA:", nama))
  print(paste("ALAMAT:", alamat))
  print("==============")
}

#call tanpa parameter, maka parameter default akan dipakai
cetak.data()

#call dengan 1 parameter
cetak.data(300)

#call dengan 2 parameter
cetak.data(300,"DADANG")
cetak.data(nama = "amir")



#Memanggil function dengan parameter urut seperti definisi
cetak.data(100,"amir","Jl dr. Sutomo")
