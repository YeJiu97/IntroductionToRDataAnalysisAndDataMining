####独立样本秩和检验
library(Hmisc)
mydata <- spss.get('NO.26 配套数据.sav',
                   use.value.labels = TRUE)
#1、比较不同婚姻状况的学历差异
table(mydata$婚姻状况)
#使用K独立样本秩和检验
kruskal.test(mydata$文化~mydata$婚姻状况)
#如果存在显著差异，则继续计算中位数
#分组计算中位数aggregate
#aggregate()

#2、比较男和女在学历等级上的差异
#两组的秩和检验，2独立样本的秩和检验
wilcox.test(mydata$文化~mydata$性别)
class(mydata$文化)
table(mydata$文化)
library(do)
mydata$文化新 <- mydata$文化
mydata$文化新 <- Replace(mydata$文化新,
                      from = '文盲',
                      to = 1)
mydata$文化新 <- Replace(mydata$文化新,
                      from = '小学',
                      to = 2)
mydata$文化新 <- Replace(mydata$文化新,
                      from = '初中',
                      to = 3)
mydata$文化新 <- Replace(mydata$文化新,
                      from = '高中',
                      to = 4)
mydata$文化新 <- Replace(mydata$文化新,
                      from = '本科',
                      to = 5)
mydata$文化新 <- Replace(mydata$文化新,
                      from = '研究生及以上',
                      to = 6)

table(mydata$文化新)
class(mydata$文化新)
mydata$文化新 <- as.numeric(mydata$文化新)
class(mydata$文化新)


#进行两独立样本秩和检验
wilcox.test(mydata$文化新~mydata$性别)
#得出了存在显著差异的结论后，还需要继续比较中位数

aggregate(x=list(mydata$文化新),
          by = list(mydata$性别),
          FUN = quantile)
          






