####K个相关样本非参检验
#1、friedman.test()(差异显著的情况)
#比较三个状态下的连续型变量的差异
#1.1 正态性检验
apply(mydata1[,2:4], 2, shapiro.test)
#其中任意一个非正态，
#则选择K个相关样本非参检验中的friedman检验

#1.2 friedman检验对数据的要求并整理
#friedman检验要求数据必须是矩阵matrix
ma1 <- as.matrix(mydata1[,2:4])
38*3
dimnames(ma1) <- list(1:38, 
                      c('术前','术后1周','术后4周'))

#1.3 friedman检验
friedman.test(ma1)
#得出P<0.05, 意味着三个状态存在显著差异，因此，
#还需要继续进行两两比较，确定具体哪两个状态之间存在显著差异


#1.4 事后多重比较
#PMCMRplus程序包是专门用于两两比较的程序包
library(PMCMRplus)
frdAllPairsNemenyiTest(ma1, 
                       p.adjust='bonferroni')


#1.5 表格制作
source('中位数函数.txt')
res1 <- apply(ma1, 2, 中位数描述)
res1 <- data.frame(res1)
res2 <- friedman.test(ma1)
res1$chisq <- c(res2$statistic, 'NA','NA')
res1$p <- c(res2$p.value, 'NA','NA')
write.csv(res1,'res1.csv')



#2、friedman.test()(差异不显著的情况)
#更进一步进行Kendall协同系数检验
ma2 <- as.matrix(mydata2[,2:5])
dimnames(ma2) <- list(1:50,
    c('评委1','评委2','评委3','评委4'))
#2.1 首先进行差异比较
friedman.test(ma2)
#得出P=0.26>0.05,意味着4个评委的结果差异不显著
#即4个评委的结果一致。
#接下来，需要选择Kendall协同系数检验计算一致程度
#Kendall协同系数检验需要用到irr程序包中的kendall函数
library(irr)
kendall(ma2)
#kendall's W检验得出P<0.05,意味着四个评委的结论显著一致
#一致程度为0.846，说明四个评委给出的评价结果一致程度较高。



res3 <- apply(ma2, 2, 中位数描述)
res3 <- data.frame(res3)
write.csv(res3,'res3.csv')



#3、Cochran's Q检验
#Cochran's Q检验用到的是DescTools程序包中的CochranQ函数
library(DescTools)
#CochranQTest()也是要求矩阵matrix形式的数据
ma3 <- as.matrix(mydata3[,2:5])
dimnames(ma3) <- list(1:57,
                      c('评委1','评委2','评委3','评委4'))
CochranQTest(ma3)
#得出P=0.601>0.05意味着4个评委的结论不存在显著差异。

#假设，存在显著差异，怎么进行事后多重比较？
#两两比较：配对卡方
choose(4,2)

library(gmodels)
k <- function(i,j){
  CrossTable(mydata3[,i], 
             mydata3[,j],
             mcnemar = TRUE,
             expected = TRUE)
}
mydata3 <- as.data.frame(mydata3)
k(2,5)


