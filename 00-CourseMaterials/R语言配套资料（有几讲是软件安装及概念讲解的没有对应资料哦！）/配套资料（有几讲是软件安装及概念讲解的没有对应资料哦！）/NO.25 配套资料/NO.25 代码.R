####K独立样本非参数检验
#1、导入SPSS格式的数据
library(Hmisc)
mydata <- spss.get('NO.25 配套数据.sav',
                   use.value.labels = TRUE)


#2、正态性检验
tapply(mydata$SS, 
       mydata$分组, 
       shapiro.test)

#3、K独立样本非参数检验
#K独立样本非参数检验使用的函数是kruskal.test()
#kruskal.test()代码格式
kruskal.test(mydata$SS~mydata$分组)
#以上检验得出P=0.025<0.05,意味着三组间的
#SS存在显著差异。
#得出了显著差异的结论之后，还需要继续
#进行两两比较，得出具体每两组之间的差异

#4、两两比较
#K独立样本非参数检验的两两比较会用到
#wmc函数。
source('wmc.txt')
wmc(mydata$SS~mydata$分组, data = mydata,
    method = 'holm')
#以上两两比较得出动力障碍样型和溃疡样型
#之间的SS存在显著差异。
#为了更进一步得出具体什么差异，哪组高：
#哪组低？
#还需要继续比较中位数。



#5、计算中位数
#非参数检验的数据为非正态数据，因此
#数据的表达形式是：中位数（下四分位数~上四分位数）
aggregate(x = list(mydata$SS),
          by = list(mydata$分组),
          FUN = median)
#最终结论是：动力障碍样型显著低于溃疡样型



#####多个变量一起进行K独立样本非参数检验
#1、正态性
for(i in 6:8){
  print(colnames(mydata)[i])
  print(tapply(mydata[,i], 
         mydata$分组, 
         shapiro.test))
}
#基于以上的结果，选择K独立样本非参数
#检验比较三组的差异。

#2、首先进行描述性统计分析
#中位数（下四分位数~上四分位数）

中位数描述 <- function(x){
  paste0(round(median(x),2),
         '(',
         round(quantile(x,prob = 0.25),2),
         '~',
         round(quantile(x,prob = 0.75),2),
         ')')
}


res1 <- aggregate(x = list(mydata[,6:8]),
          by = list(mydata$分组),
          FUN = 中位数描述)

res1 <- t(res1)
write.csv(res1, 'res1.csv')


#3、K独立样本非参数检验
for(i in 6:8){
  print(colnames(mydata)[i])
  print(kruskal.test(mydata[,i]~mydata$分组))
}

#4、两两比较
for(i in 6:8){
  print(colnames(mydata)[i])
  print(wmc(mydata[,i]~mydata$分组, data = mydata,
      method = 'holm'))
}





