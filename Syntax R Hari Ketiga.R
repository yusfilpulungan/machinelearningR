#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KETIGA_Rabu 22 Mei 2019

#=============================================================
#=============================================================
#=============================================================
#SPARKR 
#=============================================================
#=============================================================
#=============================================================

install.packages("SparkR")

library(SparkR)
#konek ke sparkr

sparkR.session()

#read.df ADALAH function di sparkr yang digunakan untuk membaca csv, dan langsung terconvert menjadi sparkr dataframe

kary<-read.df("hdfs://localhost:9000/dataku/employees.csv", header="true", source="csv")

#lihat 10 baris pertama dari dataframe anda
head(kary)

#lihat 15 baris pertama dari dataframe anda
head(kary,15)

#lihat jumlah baris dan kolom dalam dataframe
baris<-nrow(kary)
kolom<-ncol(kary)

#Melihat semua isi dataframe
head(kary,nrow(kary))

#melihat sebagian kolom dari dataframe
cols<-c("EMPLOYEE_ID","FIRST_NAME","SALARY")
kary_lim<-select(kary,cols)
head(kary_lim,nrow(kary_lim))

#Merename kolom di dalam dataframe
old_col<-c("EMPLOYEE_ID","FIRST_NAME","LAST_NAME","EMAIL","PHONE","HIRE_DATE","JOBS","SALARY","COMMISSION_PCT","MANAGER_ID","DEPARTMENT_ID")
new_col<-c("NIP","NDEPAN","NBLKG","EMAIL","TELP","TGL_MASUK","POSISI","GAJI","KOMISI","NIP_MANAGER","KODE_DEP")

for(i in 1: 11)
{
  kary<-withColumnRenamed(
    kary,
    existingCol=old_col[i],
    newCol=new_col[i]
  )
}

kary<-read.df("hdfs://localhost:9000/dataku/employees.csv", header="true", source="csv")

#CONTOH MELAKUKAN AGREGASI, MENGHITUNG RATA-RATA GAJI PADA DATAFRAME
kary1<-agg(kary,rata_rata_gaji=avg(kary$SALARY))
head(kary1)


#CONTOH MELAKUKAN GROUPING DATA PADA DATAFRAME
#MIRIP GROUP BY PADA SQL

kelompok<-groupBy(kary,kary$DEPARTMENT_ID)

kary2<-agg(kelompok, gaji_avg=avg(kary$SALARY),count=n(kary$EMPLOYEE_ID))
head(kary2)

#CONTOH MENGURUTKAN DATA DALAM DATAFRAME
kary2_ar<-arrange(kary2,desc(kary2$gaji_avg))
head(kary2_ar)


#CONTOH MENAMBAHKAN 1 KOLOM BARU YANG MERUPAKAN HASIL KALKULASI PADA DATA FRAME

kary3<-withColumn(kary,"KOMISI",kary$COMMISSION_PCT*kary$SALARY)
head(kary3,nrow(kary3))


#CARA MENGKOPI SEBAGIAN DATA DI DALAM SPARK DATAFRAME KE LOCAL DATAFRAME
df.lokal<-take(kary,num=5)
df.lokal

#CARA MENGKOPI SEMUA DATA DI DALAM SPARK DATAFRAME KE LOCAL DATAFRAME
df.semua<-collect(kary)
df.semua

#CARA MEMFILTER DATAFRAME (MIRIP "WHERE CLAUSE" DALAM SQL)
#satu macam
kary_prog<-filter(kary, trim(kary$JOBS)=="IT_PROG")
head(kary_prog)
#beberapa macam
kary_prog<-filter(kary, trim(kary$JOBS)=="IT_PROG"|trim(kary$JOBS)=="ST_CLERK")
head(kary_prog)

#MENJALANKAN FUNCTION2 STATISTIK DI DALAM DATAFRAME
#sumary adalah dataframe
summary<-describe(kary,"SALARY")

#INI HANYA MENCETAK METADATA DATAFRAME (BUKAN ISINYA)
print(summary)

#INI MENCETAK ISI DATAFRAME
head(summary)

#RENTANG NILAI GAJI
#Casting/Convert type data dari string ke float (ada decimal) atau integer (tidak ada decimal)
kary$SALARY<-cast(kary$SALARY,"float")
mr_range<-agg(kary, minimum = min(kary$SALARY), maximum = max(kary$SALARY), range_width= abs(max(kary$SALARY) - min(kary$SALARY)))
head(mr_range)

#Melihat porsi/frequensi/persentase data dalam data frame
jumlah.record<-nrow(kary)
zb<-agg(groupBy(kary,kary$JOBS),Count=n(kary$JOBS),Percentage=n(kary$JOBS)*(100/jumlah.record))
head(zb)

#membuat contingency table
con_tab<-crosstab(kary,"FIRST_NAME","JOBS")
con_tab

#=============================================================
#=============================================================
#=============================================================
#MELAKUKAN JOIN DATA FRAME YANG ADA DI SPARK 
#=============================================================
#=============================================================
#=============================================================

#Siapkan dua dataframe yang akan di joint
kary<-read.df("hdfs://localhost:9000/dataku/employees.csv", header="true", source="csv")
head(kary)
dept<-read.df("hdfs://localhost:9000/dataku/departments.csv", header="true", source="csv")
head(dept)

#Siapkan nama-nama kolom
cols_a<-c("EMPLOYEE_ID","FIRST_NAME","JOBS","DEPARTMENT_ID")
cols_b<-c("DEPARTMENT_ID","DEPARTMENT_NAME")

#jalankan select statement
a<-select(kary, cols_a)
b<-select(dept, cols_b)

#Lakukan jointdataframe
ab1<-join(a,b,trim(a$DEPARTMENT_ID)==trim(b$DEPARTMENT_ID))
head(ab1)

#===================================
#Contoh Soal

#SIAPKAN 5 DATAFRAME YANG AKAN DI JOIN
employees<-read.df(
  "hdfs://localhost:9000/dataku/employees.csv",
  header="true",
  source="csv"
)

departments<-read.df(
  "hdfs://localhost:9000/dataku/departments.csv",
  header="true",
  source="csv"
)

locations<-read.df(
  "hdfs://localhost:9000/dataku/locations.csv",
  header="true",
  source="csv"
)

countries<-read.df(
  "hdfs://localhost:9000/dataku/countries.csv",
  header="true",
  source="csv"
)

regions<-read.df(
  "hdfs://localhost:9000/dataku/regions.csv",
  header="true",
  source="csv"
)

head(employees)			
head(departments)
head(locations)
head(countries)
head(regions)

#SIAPKAN NAMA2 KOLOM YG AKAN DI SELECT DI MASING2 DATAFRAME
col_regions<-c("REGION_ID","REGION_NAME")
col_countries<-c("COUNTRY_ID","COUNTRY_NAME","REGION_ID")
col_locations<-c("LOCATION_ID","CITY","COUNTRY_ID")
col_departments<-c("DEPARTMENT_ID","DEPARTMENT_NAME","LOCATION_ID")
col_employees<-c("FIRST_NAME","DEPARTMENT_ID")

#JALANKAN PERINTAH SELECT DI MASING2 DATAFRAME
data.regions<-select(regions,col_regions)
data.countries<-select(countries,col_countries)
data.locations<-select(locations,col_locations)
data.departments<-select(departments,col_departments)
data.employees<-select(employees,col_employees)

#LAKUKAN JOIN DI TIAP 2 TABLE
rc<-join(
  regions,
  countries,
  trim(regions$REGION_ID)==trim(countries$REGION_ID)
)

rcl<-join(
  rc,
  locations,
  trim(rc$COUNTRY_ID)==trim(locations$COUNTRY_ID)
)

rcld<-join(
  rcl,
  departments,
  trim(rcl$LOCATION_ID)==trim(departments$LOCATION_ID)
)	

rclde<-join(
  rcld,
  employees,
  trim(rcld$DEPARTMENT_ID)==trim(employees$DEPARTMENT_ID)
)		


#PILIH KOLOM YG AKAN DI TAMPILKAN DALAM REPORT		
col_report<-c(
  "FIRST_NAME",
  "DEPARTMENT_NAME",
  "CITY",
  "COUNTRY_NAME",
  "REGION_NAME"
)

hasil_akhir<-select(rclde,col_report)

head(hasil_akhir)


#=============================================================
#=============================================================
#=============================================================
#MYSQL
#=============================================================
#=============================================================
#=============================================================

#Cara membuat Sparkr dataframe, dengan sumber data dari database

employees<-read.jdbc
(
  url="jdbc:mysql://localhost:3306/hr",
  source="jdbc",
  driver="com.mysql.jdbc.Driver",
  tableName="employees",
  user="hr",
  password="hr"
  )

head(employees)

