#####多元线性回归
#多元线性回归的函数lm()
#lm()代码格式
#lm(因变量~自变量1+自变量2+...+自变量n,
#      data = 数据框)

result <- lm(mydata$工作满意度~mydata$环境满意度+
     mydata$薪资满意度+mydata$工作内容满意度+
     mydata$工作能力, data = mydata)
full_result <- summary(result)
tab <- round(full_result$coefficients,3)
write.csv(tab, 'tab.csv')

#模型的诊断
#1.1 DW 序列相关
#计算DW需要使用lmtest程序包
library(lmtest)
dwtest(result)


#1.2 VIF值
#VIF值的计算会用到car包中的vif()函数
#VIF值小于5则认为自变量之间不存在共线性
library(car)
vif <- round(vif(result),3)
vif <- c('NA', vif)
vif
tab <- data.frame(tab, vif)
write.csv(tab, 'tab.csv')


#1.3 残差检验
#残差检验需要用到performance程序包check_model函数
library(performance)
check_model(result)
y

