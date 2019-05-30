#PELATIHAN MACHINE LEARNING_LATIHAN R HARI KEEMPAT_Kamis 23 Mei 2019 (Part 1)


#=============================================================
#=============================================================
#=============================================================
#MYSQL
#=============================================================
#=============================================================
#=============================================================

#Cara membuat Sparkr dataframe, dengan sumber data dari database

employees<-read.jdbc(url="jdbc:mysql://localhost:3306/hr",source="jdbc",driver="com.mysql.jdbc.Driver",tableName="employees",  user="hr",password="hr")
departments<-read.jdbc(url="jdbc:mysql://localhost:3306/hr",source="jdbc",driver="com.mysql.jdbc.Driver",tableName="departments",  user="hr",password="hr")
locations<-read.jdbc(url="jdbc:mysql://localhost:3306/hr",source="jdbc",driver="com.mysql.jdbc.Driver",tableName="locations",  user="hr",password="hr")
countries<-read.jdbc(url="jdbc:mysql://localhost:3306/hr",source="jdbc",driver="com.mysql.jdbc.Driver",tableName="countries",  user="hr",password="hr")
regions<-read.jdbc(url="jdbc:mysql://localhost:3306/hr",source="jdbc",driver="com.mysql.jdbc.Driver",tableName="regions",  user="hr",password="hr")
head(employees)

#Register dataframe ke spark, agar menjadi temporary/virtual table
createOrReplaceTempView(employees,"employees")
createOrReplaceTempView(departments,"departments")
createOrReplaceTempView(locations,"locations")
createOrReplaceTempView(countries,"countries")
createOrReplaceTempView(regions,"regions")

data.employees<-sql("SELECT*FROM employees")
head(data.employees)

emp.report<-sql("SELECT e.FIRST_NAME, d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME, r.REGION_NAME FROM employees e, departments d, locations l, countries c, 
                regions r WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID AND d.LOCATION_ID=l.LOCATION_ID AND l.COUNTRY_ID=c.COUNTRY_ID AND c.REGION_ID=r.REGION_ID")


head(emp.report)
#untuk menulis di lokal
emp.lokal<-take(emp.report,nrow(emp.report))
head(emp.lokal)


#=============================================================
#=============================================================
#=============================================================
#LOGISTIC REGRESSION MENGGUNAKAN SPARK
#=============================================================
#=============================================================
#=============================================================

#Mengcopy local data frame ke spark dataframe
mtcarsDF<-createDataFrame(mtcars)
head(mtcarsDF)

#Buat model Regresion
#Step ini akan memerintahkan SPARK untuk melakukan learning proses
model<-glm(vs~mpg+disp+hp+wt, data=mtcarsDF, family="binomial")

summary(model)

#Melakukan prediksi
predictionX<-predict(model,newData=mtcarsDF)

#melihat hasil prediksi
modelPrediction<-select(predictionX, "vs","prediction")
head(modelPrediction)
