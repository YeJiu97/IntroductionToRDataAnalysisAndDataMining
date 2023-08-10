a <- c(1,2,3,4)
a
(1+2+3+4)/4
mean(a)

#1、针对单个向量编写函数
mean(a)
var(a)
sd(a)
sd(a)*sd(a)
mean(mydata$人际关系)
sd(mydata$人际关系)

均值标准差函数 <- function(x){
  paste0(round(mean(x),2), '±', round(sd(x),2))
}

均值标准差函数(mydata$人际关系)
均值标准差函数(mydata$职业认知)
均值标准差函数(mydata$职业价值)

mydata <- as.data.frame(mydata)

for(i in 3:9){
  print(均值标准差函数(mydata[,i]))
}

result <- NULL
for(i in 3:9){
  name_i <- colnames(mydata)[i]
  result_i <- 均值标准差函数(mydata[,i])
  result <- rbind(result, name_i, result_i)
}
result

names <- colnames(mydata)[3:9]
names
final <- result[seq(2,14,by=2),1]

final2 <- data.frame(names, final)
write.csv(final2, 'final2.csv')



rr <- NULL
for(i in 3:9){
  rr_i <- 均值标准差函数(mydata[,i])
  rr <- rbind(rr, rr_i)
}
rr
names2 <- colnames(mydata)[3:9]
names2
dddd <- data.frame(names2, rr)
dddd




#2、针对多个向量编写函数
#以计算BMI为例，BMI=体重（公斤）/（身高_米*身高_米）
#自定义函数的目的是为了保存一种计算规则
BMIfunction <- function(x, y){
  x/((y/100)^2)
}   #x表示体重，以公斤为单位；y表示身高，以厘米为单位

mydata$BMI <- BMIfunction(mydata$体重, mydata$身高)


h <- c(172,158,169,153,185,175,192,154,175,166)
w <- c(80,48,52,49,85,76,90,44,75,52)
BMI2 <- BMIfunction(w,h)
BMI2 












