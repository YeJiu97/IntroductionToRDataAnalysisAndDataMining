#######影响因素研究完整案例####

#导入SPSS格式的数据
library(Hmisc)   #导入SPSS格式的数据需要用到Hmisc包中的spss.get函数
mydata <- spss.get('NO.32 配套数据.sav', 
                   use.value.labels = TRUE)

#1、单因素分析
#单因素分析的本质就是差异比较
#第2-6列是连续型被检验变量
#第1、7、8、9是无序分类被检验变量


#对于连续型被检验变量的差异比较，首先需要进行正态性检验
#正态性检验
tapply(mydata$年龄, mydata$感染, shapiro.test)
#批量正态性检验，会用到循环
for(i in 2:6){
  print(colnames(mydata)[i])
  print(tapply(mydata[,i], mydata$感染, shapiro.test))
}

#基于以上的正态性检验，选择两独立样本非参进行差异比较的
#变量有：年龄（2），IgG（4），IgM（5），IgA（6）
#选择独立T比较差异的变量：维生素D（3）

#两独立非参，针对2456列
#先描述，算出四分位数
source('中位数函数.txt')
非参描述 <- aggregate(x = list(mydata[,c(2,4:6)]),
                  by = list(mydata$感染),
                  FUN = 中位数描述)


非参描述 <- t(非参描述)   #转置
colnames(非参描述) <- c('否', '是')
非参描述 <- 非参描述[-1,]

#两独立非参数检验
wilcox.test(mydata$IgG~mydata$感染, paired = FALSE)

for(i in c(2,4:6)){
  print(colnames(mydata)[i])
  print(wilcox.test(mydata[,i]~mydata$感染, paired = FALSE))
}

#提取两独立非参数检验的P值
res1 <- NULL
for(i in c(2,4:6)){
  res1i <- print(wilcox.test(mydata[,i]~mydata$感染, paired = FALSE))
res1 <- rbind(res1, res1i)
  }
非参P <- res1[,3]
非参P <- do.call(rbind, 非参P)
非参P <- data.frame(非参P)
非参P$Z <- qnorm(非参P$非参P/2)
非参描述 <- data.frame(非参描述)
非参描述 <- data.frame(非参描述, 非参P$Z, 非参P$非参P)



#两独立样本T
source('均值标准差函数.txt')
T描述 <- aggregate(x = list(mydata[,3]),
                  by = list(mydata$感染),
                  FUN = 均值标准差函数)
T描述 <- t(T描述)
t.test(mydata$维生素D~mydata$感染, paired = FALSE)
colnames(T描述) <- c('否', '是')
T描述 <- data.frame(T描述)
T描述 <- T描述[-1,]
rownames(T描述) <- '维生素D'
T描述$T <- 17.557
T描述$P <- '<0.001'


#连续变量的差异结果汇总
T描述 <- edit(T描述)
非参描述 <- edit(非参描述)
连续汇总 <- rbind(T描述[1,], 非参描述[1:4,])
write.csv(连续汇总, '连续汇总.csv')


#分类型变量的差异比较
#卡方检验
library(gmodels)
CrossTable(mydata$性别,mydata$感染, chisq = TRUE,
           expected = TRUE,
           fisher = TRUE)

res2 <- NULL
for(i in c(1,7:9)){
  print(colnames(mydata)[i])
  res2i <- CrossTable(mydata[,i],mydata$感染, chisq = TRUE,
             expected = TRUE)
  res2 <- rbind(res2, res2i)
}

人数 <- res2[,1]
人数 <- do.call(rbind, 人数)

行占比 <- res2[,2]
行占比 <- do.call(rbind, 行占比)

卡方结果 <- res2[,5]
卡方结果 <- do.call(rbind, 卡方结果)
卡方值 <- 卡方结果[,1]
卡方值 <- do.call(rbind, 卡方值)

卡方P <- 卡方结果[,3]
卡方P <- do.call(rbind, 卡方P)




人数 <- data.frame(人数)
行占比 <- data.frame(行占比)

人数行占比 <- cbind(人数, 行占比)
人数行占比 <- edit(人数行占比)
人数行占比$合并 <- paste0(人数行占比$否,
                   '(',
                   round(人数行占比$ZBF*100,2),
                   '%)')
人数行占比$合并2 <- paste0(人数行占比$是,
                   '(',
                   round(人数行占比$ZBT*100,2),
                   '%)')
write.csv(人数行占比, '人数行占比.csv')
write.csv(卡方值, '卡方值.csv')
write.csv(卡方P, '卡方P.csv')

#以上完成了全部的单因素分析


#2、多因素分析
#基于以上的单因素分析可以清晰得出，
#维生素D、IgG、IgA、糖尿病、高血压这几个因素通过
#了单因素筛查，需要保留参与后续的多因素分析；
#而感染和未感染两组在年龄、IgM、性别、冠心病这
#几个因素不存在显著差异，因此这几个因素可以直接
#删除。




#以维生素D、IgG、IgA、糖尿病、高血压为自变量，
#术后感染为因变量，
#进行二元logistic回归分析


str(mydata)

model <- glm(mydata$感染=='是'~mydata$维生素D
             +mydata$IgG
             +mydata$IgA
             +mydata$糖尿病
             +mydata$高血压,
             family = binomial,
             data = mydata)

res3 <- summary(model)

table <- res3$coefficients

table <- data.frame(table)
table$OR <- exp(table[,1])
confint <- confint(model)
confint <- data.frame(confint)
table <- cbind(table, confint)
table$OR_LL <- exp(table[,6])
table$OR_UL <- exp(table[,7])
write.csv(table, 'table.csv')

#以上的多因素分析全部完成


