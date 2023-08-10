#apply函数
#对于某一些重复循环计算，既可以使用for循环，
#也可以使用apply函数族。
#apply函数族包含apply、lapply、sapply、vapply、mapply等函数
#本次课程讲解最常用的apply函数


#apply函数的代码结构
# apply(数据框, 行1/列2, function)


#实例演示apply函数的应用
#由于tbl_df后期使用的时候容易报错，所以
#先将其转换成普通的df
mydata1 <- data.frame(mydata1)
mydata2 <- data.frame(mydata2)

#求mydata2中最后4列变量的均值。
#1、apply函数实现以上的需求
ss <- mydata2[,5:8]
apply(mydata2[,5:8], 2, mean)

#2、for循环实现以上的需求
for(i in 5:8){
  print(mean(mydata2[,i]))
}


apply(mydata2[,5:8], 2, sd)
apply(mydata2[,5:8], 2, max)
apply(mydata2[,5:8], 2, shapiro.test)

# apply(数据框, 行/列, function)

#apply函数中的function既可以是R自带的函数，也可以是
#自编的函数，无论是哪种函数，均要求这个函数必须是针对
#单一向量的。


#演示单一向量的自变函数与apply函数的结合使用
#求mydata2中最后4列变量的均值±标注差。
#调用自变函数
source('均值标准差函数.txt')
apply(mydata2[,5:8], 2, 均值标准差函数)

res1 <- apply(mydata2[,5:8], 2, 均值标准差函数)
class(res1)

View(res1)
res1 <- data.frame(res1)
View(res1)
write.csv(res1, 'res1.csv')


#求mydata2中最后4列变量的均值、标注差、最大值、最小值
des <- function(x){
  data.frame(min(x), max(x), mean(x), sd(x), var(x))
}

apply(mydata2[,5:8], 2, des)
res2 <- apply(mydata2[,5:8], 2, des)
View(res2)
#将res2从list转成df，转换的函数是do.call
res2 <- do.call(rbind, res2)
View(res2)
write.csv(res2, 'res2.csv')

#以上均为apply函数按照列的应用案例
#以下则以apply函数按照行的案例应用：
#以下案例使用的数据为量表数据
#量表数据操作的第一步一定是逆向化处理。
#逆向化处理也是apply函数的自编函数应用案例
#逆向化处理，本质就是变量的重新编码。
#会用到car包中的recode函数
library(car)
re <- function(x){
  recode(x, '1=5;2=4;3=3;4=2;5=1')
}
apply(mydata1[,c(7,9,13)], 2, re)
res3 <- apply(mydata1[,c(7,9,13)], 2, re)
colnames(res3) <- c('M6_n', 'M8_n', 'M12_n')
mydata1 <- data.frame(mydata1, res3)

mydata1$继续 <- (mydata1$M3+mydata1$M6_n+mydata1$M8_n+mydata1$M11+mydata1$M19+mydata1$M24)/6
c(4,29:30,12,20,25)
#本质是计算每一个样本的均值，所以是以行为单位
mydata1$继续承诺 <- apply(mydata1[,c(4,29:30,12,20,25)], 1, mean)





