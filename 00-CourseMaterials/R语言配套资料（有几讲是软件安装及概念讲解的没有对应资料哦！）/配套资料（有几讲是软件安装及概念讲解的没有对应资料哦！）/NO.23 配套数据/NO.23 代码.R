mydata$代谢综合征 <- factor(mydata$代谢综合征,
                       levels = c(0,1),
                       labels = c('无', '有'))
####两独立样本非参数检验
#1、正态性检验
mydata <- as.data.frame(mydata)
tapply(mydata[,5],
       mydata[,13],
       shapiro.test)
#以上正态性检验结果显示，有代谢综合征组
#的HDL非正态，因此选择两独立样本非参数检验
#进行差异比较。


#2、两独立样本非参数检验
# wilcox.test(被检验变量~分组变量, paired = T/F)
res1 <- wilcox.test(mydata$HDL~mydata$代谢综合征,
            paired = FALSE)
#两独立样本非参数检验的P>0.05,意味着两组间无显著差异
#如果P<0.05，则认为差异显著，需要继续比较
#两组的中位数
aggregate(x = list(mydata$HDL),
          by = list(mydata$代谢综合征),
          FUN = median)

Z <- qnorm(res1$p.value/2)
Z



#多变量的综合演示
#1、正态性检验
for(i in 2:12){
  print(tapply(mydata[,i],
         mydata[,13],
         shapiro.test))
}
#以上结果清晰显示，所有变量至少都在一组上
#非正态分布，因此选择两独立样本非参数检验
#且数据的表达形式选择中位数（下四分位数~上四分位数）

#2、编写中位数（下四分位数~上四分位数）函数
中位数表达 <- function(x){
  paste0(median(x),
         '(', 
         quantile(x,prob = 0.25),
         '~',
         quantile(x,prob = 0.75),
         ')')
}

res2 <- aggregate(x = list(mydata[,2:12]),
          by = list(mydata$代谢综合征),
          FUN = 中位数表达)
res2 <- t(res2)
res2 <-res2[-1,]
colnames(res2) <- c('无', '有')

#3、两独立样本非参数检验
p <- NULL
for(i in 2:12){
  pi <- wilcox.test(mydata[,i]~mydata[,13],
              paired = FALSE)
  p <- rbind(p, pi)
}
p <- p[,3]

View(p)
p <- do.call(rbind, p)
View(p)
colnames(p) <- 'p'
p <- data.frame(p)
p$Z <- qnorm(p$p/2)

final <- cbind(res2, p[,2], p[,1])

write.csv(final,'final.csv')

