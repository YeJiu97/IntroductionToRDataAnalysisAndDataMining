####描述性统计分析###
#将mydata转换成普通的df
mydata <- as.data.frame(mydata)
mydata$性别 <- factor(mydata$性别, 
                    levels = c(1,2),
                    labels = c('男', '女'))
mydata$代谢综合征 <- factor(mydata$代谢综合征, 
                    levels = c(0,1),
                    labels = c('无', '有'))


#对连续型变量的描述统计分析
summary(mydata[,c(2,4:14)])
res1 <- summary(mydata[,c(2,4:14)])
View(res1)
#使用summary函数进行描述性统计分析的缺点：
#输出的结果制作成表格比较麻烦，会增加很多工作量
#推荐大家使用describe函数进行描述性统计分析

#describe()函数不是R自带的函数
#describe()函数在"psych"程序包中
#1、下载安装"psych"程序包
#2、调用"psych"程序包
library(psych)
describe(mydata[,c(2,4:14)])
res2 <- describe(mydata[,c(2,4:14)])
write.csv(res2, 'res2.csv')

#增加上下四分位数的计算
describe(mydata[,c(2,4:14)], quant = c(.25,.75))


#正态性检验
#1、样本量<2000：shapiro.test()  
#2、样本量≥2000：ks.test(x, "pnorm")  
#P>0.05表示服从正态分布

apply(mydata[,c(2,4:14)], 2, shapiro.test)
ks.test(mydata$年龄, 'pnorm')


#直方图的绘制,正态曲线的绘制
hist(mydata$年龄)


h <- c(1.1,2.2,2.3,3.1,3.2,3.3,4.2,4.6,4.7,5.5,5.8,6.7)
hist(h)  #频数直方图，以频数为纵坐标
length(h)

1/12
2/12
fre <- c(1,2,3,3,2,1)
den <- fre/12
den
hist(h, freq = FALSE)  #频率直方图，以频率为纵坐标
#如果我们需要在直方图中增加正态曲线，那么只能在频率直方图中增加正态曲线
#直方图中增加正态曲线
curve(dnorm(x, mean = mean(h), sd = sd(h)), add = TRUE, col = 'blue')


#绘制年龄的直方图
hist(mydata$年龄, freq = FALSE, ylim = c(0,0.06))
#在年龄直方图中添加正态曲线
curve(dnorm(x, mean = mean(mydata$年龄), sd = sd(mydata$年龄)), 
      add = TRUE, col = 'blue')


###分类变量的描述性统计分析
table(mydata$性别)
table(mydata$代谢综合征)

for(i in c(3,15)){
  print(table(mydata[,i]))
}









