a <- c(1,2,3,4)  #数值型向量num
b <- c('上海', '北京', '广州', '深圳') #字符型向量chr
d <- c(TRUE, TRUE,FALSE,FALSE)#逻辑型向量logi

#######NO.9时间日期向量#####
#1、日期向量Date            YYYY-mm-dd
#2、时间向量POSIXct         YYYY-mm-dd HH:MM:SS
l <- c("2022-11-22", '2022-11-01', '2022-11-03')
l <- as.Date(l)  #日期是以字符的形式进入R的，进入后需要人为转换成Date形式
k <- c('2022-11-22 17:06:23', '2022-11-01 12:35:29', '2022-11-03 21:18:09')
k <- as.POSIXct(k)

#3、lubridate针对时间日期变量的程序包
library(lubridate)
#3.1 提取日期向量的年、月、日、季度
year(l)
month(l)
day(l)
quarter(l)
#3.2 提取时间向量的小时、分钟、秒
year(k)
month(k)
day(k)
quarter(k)
hour(k)
minute(k)
second(k)

#4、时间向量和日期向量的加减法
l
s <- l+3
s

k
f <- k+30
f



#5、实例演示时间差、日期差的计算方法
mydata <- NO_9_配套数据
str(mydata)

#5.1 使用lubridate程序包中的ymd函数把变量类型改成Date
mydata$入院日期 <-  ymd(mydata$入院日期) #把变量类型改成Date
mydata$手术日期 <-  ymd(mydata$手术日期) #把变量类型改成Date
str(mydata)

#5.2 生成正确的时间变量
mydata$手术开始_完整时间 <- paste(mydata$手术日期, 
                          mydata$手术开始时间, 
                          sep = ' ')
mydata$手术结束_完整时间 <- paste(mydata$手术日期, 
                          mydata$手术结束时间, 
                          sep = ' ')
class(mydata$手术开始_完整时间)
str(mydata)
mydata$出院日期 <- ymd(mydata$出院日期)
mydata$手术开始_完整时间 <- ymd_hms(mydata$手术开始_完整时间)
mydata$手术结束_完整时间 <- ymd_hms(mydata$手术结束_完整时间)
str(mydata)

#5.3 计算时间差
mydata$手术等待时间 <- difftime(mydata$手术日期,
                          mydata$入院日期, 
                          units = 'days')
mydata$手术时长 <- difftime(mydata$手术结束_完整时间, 
                        mydata$手术开始_完整时间,
                        units = 'hours')





