mydata$胃电图 <- factor(mydata$胃电图,
                     levels = c(0,1),
                     labels = c('正常','异常'))
###独立样本T检验
#1、考察SPS物质是否服从正态分布
#注意：分别对每一组都进行正态性检验
table(mydata$胃电图)
shapiro.test(mydata$SP物质)  #针对全体样本
#我们需要的是针对每一组分别进行正态性检验
apply(mydata[,6], 
      2, #一整列
      shapiro.test) #整体正态

mydata <- as.data.frame(mydata)
#以下是报错代码
aggregate(x = list(mydata[,6]),
          by = list(mydata[,2]),
          FUN = shapiro.test)#aggregate中用到的函数必须是描述统计函数

#分组进行正态性检验的函数是tapply
#tapply函数可以将运算应用到各个组中！
#tapply(向量, 分组, 函数)
tapply(mydata[,6],#被检验变量SP物质
       mydata[,2], #分组变量
        shapiro.test) #两组的P都大于0.05
#即可以使用独立T检验比较两组的SP物质均值差异


#独立样本T检验分为两种情况：
#1、基于方差相等的独立样本T检验
#2、基于方差不相等的独立样本T检验

#独立T检验的函数t.test的代码格式：
#t.test(被检验变量~分组变量, var.equal = T/F)
#因此，在进行独立T之前，还需要考察方差齐性的问题。
#var.test(被检验变量~分组变量)
var.test(mydata[,6]~mydata[,2])
#F方差齐性检验的P值>0.05意味着方差齐，否则表示方差不齐。
t.test(mydata[,6]~mydata[,2], var.equal = TRUE)



#多个变量一起进行独立T检验
p <- NULL
for(i in 3:8){
  pi <- tapply(mydata[,i],
         mydata[,2], 
         shapiro.test) 
  p <- rbind(p, pi)
}
#提取正态性检验结果
p正常 <- do.call(rbind,p[,1])
colnames(p正常)[2] <- 'p正态_正常'

p异常 <- do.call(rbind,p[,2])
colnames(p异常)[2] <- 'p正态_异常'

res_nor <- cbind(p正常[,2], p异常[,2])
rownames(res_nor) <- colnames(mydata)[3:8]
write.csv(res_nor, 'res_nor.csv')

#计算均值和标准差
source('均值标准差函数.txt')
res_mean <- aggregate(x = list(mydata[,3:8]),
          by = list(mydata[,2]),
          FUN = 均值标准差函数)

res_mean <- t(res_mean)
res_mean <- res_mean[-1,]
colnames(res_mean) <- c('正常','异常')

#方差齐性
for(i in 3:8){
  print(var.test(mydata[,i]~mydata[,2]))
}
#所有变量全部方差齐

#进行独立T检验
t <- NULL
for(i in 3:8){
  ti <-t.test(mydata[,i]~mydata[,2], var.equal = TRUE)
  t <- rbind(t, ti)
}
t_value <- do.call(rbind,t[,1])

res_final <- cbind(res_mean,t_value, t[,3])
write.csv(res_final, 'res_final.csv')



