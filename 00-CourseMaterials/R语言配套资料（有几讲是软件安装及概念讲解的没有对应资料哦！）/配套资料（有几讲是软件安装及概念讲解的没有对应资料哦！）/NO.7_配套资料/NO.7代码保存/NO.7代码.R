########NO.7数据录入代码演示
#1、键盘手动录入数据
Patient_ID <- c('NO.1', 'NO.2', 
                'NO.3', 'NO.4',
                'NO.5', 'NO.6',
                'NO.7', 'NO.8',
                'NO.9', 'NO.10')#录入字符时务必加英文环境下的''或""
Patient_ID
Gender <- c('male', 'male', 
            'female', 'female', 
            'female', 'female', 
            'female', 'female', 
            'female', 'male')#录入字符时务必加英文环境下的''或""
Gender
Age <- c(67, 67, 60, 69, 80, 63, 55, 66, 47, 62)
mydata1 <- data.frame(Patient_ID, Gender, Age)#R是区分大小写的！
View(mydata1) #预览数据
edit(mydata1)
mydata2 <- edit(mydata1) #修改后的数据另存为一个新的数据框
mydata1 <- edit(mydata1)#修改后的结果直接覆盖原来的数据框

#2、txt格式数据的导入（txt格式数据推荐使用写代码导入）
#导入txt格式数据用到的函数是read.table，这个函数所在utils程序包是R自带的
mydata3 <- read.table("C:/Users/Administrator/Desktop/NO.7_配套资料/NO.7_txt格式数据导入.txt", header = TRUE)
#重点：R软件不能识别\的路径，R软件只能识别/或者\\的路径
mydata4 <- read.table("C:\\Users\\Administrator\\Desktop\\NO.7_配套资料\\NO.7_txt格式数据导入.txt", header = TRUE)
#重点：R软件不能识别\的路径，R软件只能识别/或者\\的路径

#3、excel格式数据的导入（既可以通过代码，也可以通过鼠标点击）
#导入excel格式数据用到的函数是read_excel，这个函数所在的程序包readxl不是R自带的，
#因此，使用之前需要install，然后在library。
mydata5 <- NO_7_excel格式数据
mydata5$性别 <- factor(mydata5$性别, levels = c(1,2), labels = c('男', '女'))


#4、csv格式数据的导入（只能通过代码，不能通过鼠标点击）
#导入csv格式数据用到的函数是read.csv，这个函数所在utils程序包是R自带的
mydata6 <- read.csv('C:\\Users\\Administrator\\Desktop\\NO.7_配套资料\\NO.7_csv格式数据.csv')

#5、SPSS格式数据的导入（既能通过代码，也能通过鼠标点击）
mydata7 <- NO_7_SPSS格式数据  #改数据框的名字




