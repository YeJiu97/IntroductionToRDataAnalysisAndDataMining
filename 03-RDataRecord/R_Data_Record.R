# 键盘手工录入
Patient_ID <- c("No.1", "NO.2")
Patient_ID <- c("NO.1","NO.2",
                "NO.3","NO.4",
                "NO.5","NO.6",
                "NO.7","NO.8",
                "NO.9","NO.10")
Patient_ID

Gender <- c("male", "male", 
            "female", "female",
            "female", "female",
            "female", "female",
            "female", "male")
Gender

Age <- c(67, 67, 60, 69, 80, 63, 55, 66, 47, 62)
Age

mydata_01 <- data.frame(Patient_ID, Gender, Age)
mydata_01

View(mydata_01)

edit(mydatal)


mydata_02 <- edit(mydata_01)
mydata_02

mydata_01
mydata_01 <- edit(mydata_01)
mydata_01


# 导入txt格式的数据
# 需要使用read.table函数
mydata_txt <- read.table("txt_data_input.txt")
mydata_txt <- read.table("txt_data_input.txt", header = TRUE)
mydata_txt


# excel格式的数据
install.packages("readxl")
library("readxl")

mydata_excel <- read_excel("excel_data_input.xls")
mydata_excel

typeof(mydata_excel$性别)
mydata_excel$性别 <- factor(mydata_excel$性别, 
                          levels = c(1, 2), labels = c('male', "female"))  # 将性别修改为分类变量
typeof(mydata_excel$性别)


# 导入csv格式数据
mydata_csv <- read.csv("csv_data_input.csv")
mydata_csv


# 导入spss格式的数据
library("haven")
mydata_spss <- read_sav("spss_data_input.sav")
mydata_spss
