#######NO.8字符串变量整理
#字符串的定义：只要内容加上了
#单引号或者双引号（英文环境下），
#那么这个内容就是字符串

x <- c(1,3,1,5)
y <- c(2,1,3,1)
x + y
#1、对于数字
#只要对向量中的元素加上引号，即变为字符形式
#对于阿拉伯数字，既可以是字符也可以是数字，
#具体是哪一种，取决于你是否给它加上引号
x1 <- c('1','3','1','5')
y1 <- c('2','1','3','1')
x1 + y1
#2、对于汉字、英文单词、英文字母等
#汉字、英文单词、英文字母等职能是字符，
#录入的时候务必加上引号。
a <- c('你好', '再见', '拜拜')
a1 <- c(你好, 再见, 拜拜)  #错误，汉字没加引号

mydata <- NO_8_配套数据

#3、求字符串的长度
nchar(mydata$职业)

#4、查找grep  grepl（查找字符串的各个元素中是否包含目标字符）
#以上的查找要求使用的函数是grep或grepl
#grep('目标字符', 字符串变量)
#grepl('目标字符', 字符串变量)
grep('辛辣', mydata$饮食偏好)
grepl('辛辣', mydata$饮食偏好)
as.numeric(grepl('辛辣', mydata$饮食偏好))
mydata$辛辣 <- as.numeric(grepl('辛辣', mydata$饮食偏好))
mydata$高脂肪饮食猪肉 <- as.numeric(grepl('高脂肪饮食猪肉', mydata$饮食偏好))

#5、提取（提取字符串中的部分字符串）
#提取函数：substr
#substr(字符串, 开始位置, 结束位置)
mydata$出生年份 <- substr(mydata$身份证号, 7, 10)
str(mydata)
mydata$出生年份 <- as.numeric(mydata$出生年份)
str(mydata)

#6、替换/删除
#gsub('被替换的内容', '替换内容', 字符串)
#6.1    gsub的删除用法
#提取mydata$姓名编号变量中的姓名，删除编号
#将编号替换成没有任何内容
mydata$姓名 <- gsub('[0-9]', '', mydata$姓名编号)

#提取mydata$姓名编号变量中的编号，删除姓名
#将姓名替换成没有任何内容
mydata$编号 <- gsub('[^0-9]', '', mydata$姓名编号)

#6.2    gsub的替换用法
#需要把身份证号中的X替换成'保密数字'
mydata$身份证号 <- gsub('X', '保密数字', mydata$身份证号)

#6.3   substr函数也可以替换
#将身份证号中的出生年份隐藏，替换成XXXX
# substr(字符串, 开始位置, 结束位置) <- '目标内容'
mydata$隐匿年份 <- mydata$身份证号
substr(mydata$隐匿年份, 7, 10) <- 'XXXX'

#7、粘贴paste    paste0
# paste(变量1, 变量2, sep = '*')
mydata$姓名编号2 <- paste(mydata$姓名, mydata$编号, sep = "*")
mydata$姓名编号3 <- paste(mydata$姓名, mydata$编号, sep = "")
# paste(变量1, 变量2, sep = '')
# paste0(变量1, 变量2)
mydata$姓名编号4 <- paste0(mydata$姓名, mydata$编号)


#8、查找（查找某一个具体内容在字符串中的位置）
#regexpr('具体内容', 字符串, fixed = TRUE)
mydata$星号位置 <- regexpr('*', mydata$姓名编号2, fixed = TRUE)

#9、拆分
#strsplit(字符串, split = '', fixed = TRUE)
aaa <- strsplit(mydata$姓名编号2, split = '*', fixed = TRUE)
#strsplit拆分后的结果不是变量，软件没法直接把拆分后的结果放进原来的数据框
#strsplit拆分后的结果是列表list，我们需要把list转成matrix或者vector或者data.frame才可以放进原来的数据框
#  do.call可以吧list转换成矩阵
#  do.call(rbind,list名字)
aaa <- do.call(rbind, aaa)
aaa <- data.frame(aaa)
colnames(aaa) <- c('姓名2', '编号2')
mydata <- data.frame(mydata, aaa)



