###配对样本T检验
#1、导入数据
library(Hmisc)
mydata <- spss.get('NO.27 配套数据.sav',
                   use.value.labels = TRUE)
mydata$差值 <- mydata$空腹血糖.治疗前-mydata$空腹血糖.治疗后

#2、正态性检验
apply(mydata[,2:4], 2, shapiro.test)
#通过了正态性检验，因此比较前后的
#空腹血糖差异选择的统计学方法是
#配对样本T检验
t.test(mydata$空腹血糖.治疗前, 
       mydata$空腹血糖.治疗后,
       paired = TRUE)
#3、描述性统计分析
source('均值标准差函数.txt')
res <- apply(mydata[,2:3], 2, 均值标准差函数)
res <- data.frame(res)
write.csv(res,'res.csv')








