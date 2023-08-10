######二元logistic回归分析###
#1、导入数据
library(Hmisc)   #导入SPSS格式的数据需要用到的程序包
mydata <- spss.get('NO.31 配套数据.sav',
                   use.value.labels = TRUE)
str(mydata)
mydata$年龄 <- as.numeric(mydata$年龄)
str(mydata)
#确保自变量的类型是准确的之后，开始进行
#二元logistic回归分析

#2、二元logistic回归分析
#二元logistic回归分析使用的函数是glm()
#glm()广义线性模型
#general linear model  函数glm()
#linear model   函数是lm()
#glm()的代码格式
#glm(方程, family = XXXXX, data = XXXX)

model <- glm(mydata$糖尿病=='有'~mydata$BMI+mydata$性别+
      mydata$吸烟+mydata$饮酒+mydata$家族史+
      mydata$年龄+mydata$腰围, 
    family = binomial, 
    data = mydata)   #建立的二元logistic回归模型

res <- summary(model)  #查看完整的运算结果
res$coefficients  #既有回归系数也有系数的显著性检验
tab <- round(res$coefficients,3)
model$coefficients    #仅仅只有回归系数
#summary(model)可以看到完整的回归系数和回归系数的显著性检验
#model仅仅只可以看到回归系数，看不到回归系数的显著性检验
#计算OR值只需要回归系数。
OR <- round(exp(model$coefficients),3)
OR
#计算OR的95%置信区间
model$coefficients
confint(model)
ORCI <- round(exp(confint(model)),3)
#OR（下~上）
OR的置信区间 <-paste0(OR,'(',ORCI[,1],'~', ORCI[,2],')')
fianl <- data.frame(tab,OR的置信区间)
#导出结果
write.csv(fianl,'fianl.csv')

exp(0)
exp(1.85)

#二元logistic回归模型的显著性检验
#也是用到lmtest
library(lmtest)
modelnull <- glm(mydata$糖尿病=='有'~1, 
                 family = binomial,
                 data = mydata)
#空模型和全模型的差异对比函数是lrtest
lrtest(model, modelnull)


#伪R方
#伪R方的计算需要用到pscl程序包中的pR2()函数
library(pscl)
pR2(model)


#预测准确率
prob <- predict(model, type = 'response')
#割点是0.5，即>=0.5认为有病，<0.5无病。
type <- ifelse(prob >= 0.5, '有1', '无1')

mydata <- data.frame(mydata, type)
aaa <- table(mydata$糖尿病, mydata$type.1)

(83+61)/(83+17+39+61)
#得出模型的预测准确率为72%
write.csv(aaa,'aaa.csv')











