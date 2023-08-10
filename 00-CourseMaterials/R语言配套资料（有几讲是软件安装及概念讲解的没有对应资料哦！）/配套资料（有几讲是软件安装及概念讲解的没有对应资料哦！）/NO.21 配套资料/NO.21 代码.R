#####相关性分析
#学历和能力考核这两个变量是等级变量
mydata$学历 <- factor(mydata$学历,
               levels = c(1,2,3,4),
      labels = c('中专','大专','本科','硕士'),
        ordered = TRUE)

mydata$能力考核 <- factor(mydata$能力考核,
                    levels = c(1,2,3),
                    labels = c('差','中','优'),
                    ordered = TRUE)
mydata$组织领导 <- round(apply(mydata[,4:9], 
                           1, mean),2)
mydata$常规工作 <- round(apply(mydata[,10:14], 
                           1, mean),2)
mydata$病患处理 <- round(apply(mydata[,15:26], 
                           1, mean),2)
mydata$人际关系 <- round(apply(mydata[,27:30], 
                           1, mean),2)
mydata$护理认同 <- round(apply(mydata[,31:34], 
                           1, mean),2)
mydata$职业认知 <- round(apply(mydata[,35:39], 
                           1, mean),2)
mydata$职业价值 <- round(apply(mydata[,40:48], 
                           1, mean),2)
mydata$职业规划 <- round(apply(mydata[,49:52], 
                           1, mean),2)

#pearson相关
#求相关系数的函数是cor()
cor(mydata$组织领导, mydata$护理认同)
#相关系数是否显著，函数是cor.test()
cor.test(mydata$组织领导, mydata$护理认同)
##相关性分析的解析：
#1、P<0.05,意味着变量之间存在显著相关，才有资格继续分析相关系数
#如果P>0.05,意味着变量之间无显著相关，分析结束。

#2、得出显著相关的结论之后，再分析相关系数
#2.1   如果相关系数>0,正相关
#2.2   如果相关系数<0,负相关

#3、得出了显著的正或者显著的负相关之后，还需要考察强弱问题
#3.1 如果相关系数的绝对值<0.3,极弱相关
#3.2 如果相关系数的绝对值[0.3,0.5],弱相关
#3.3 如果相关系数的绝对值(0.5,0.7],中等相关
#3.4 如果相关系数的绝对值>0.7,强相关


cor(mydata$组织领导, mydata$护理认同)
cor(mydata$组织领导, mydata$护理认同, 
    method = 'pearson')
cor.test(mydata$组织领导, mydata$护理认同,
         method = 'pearson')

res1 <- round(cor(mydata[,53:60]),2)
write.csv(res1, 'res1.csv')

mydata <- data.frame(mydata)
cor.test(mydata[,53],mydata[,54])


#相关性分析结果的绘图
#相关性分析的绘图用到的是corrgram程序包中的corrgram函数
library(corrgram)
corrgram(mydata[,53:60])
corrgram(mydata[,53:60],
         upper.panel = panel.conf)



#spearman相关
cor(mydata$学历,mydata$病患处理, 
    method = 'spearman')
class(mydata$学历)
library(do)
mydata$学历 <- Replace(mydata$学历, from = '中专',
        to = 1)
mydata$学历 <- Replace(mydata$学历, 
                     from = '大专',
                     to = 2)

mydata$学历 <- Replace(mydata$学历, 
                     from = '本科',
                     to = 3)

mydata$学历 <- Replace(mydata$学历, 
                     from = '硕士',
                     to = 4)
class(mydata$学历)
mydata$学历 <- as.numeric(mydata$学历)
class(mydata$学历)

cor(mydata$学历,mydata$病患处理, 
    method = 'spearman')
cor.test(mydata$学历,mydata$病患处理, 
    method = 'spearman')




