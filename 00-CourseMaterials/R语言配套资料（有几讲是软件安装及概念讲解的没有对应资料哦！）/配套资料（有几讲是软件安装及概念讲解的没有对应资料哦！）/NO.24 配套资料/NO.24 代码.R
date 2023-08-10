#####单因素方差分析
#导入SPSS格式的数据
library(Hmisc)
mydata <- spss.get('NO.24 配套数据.sav',
                   use.value.labels = TRUE)

#1、正态性检验
tapply(mydata[,3],
       mydata[,2], 
       shapiro.test)
#三组的胃半排空时间全部服从正态分布，
#因此选择单因素方差分析比较三组的均值差异

#2、判断组间的方差齐性
#方差齐性检验使用的是car程序包中的leveneTest函数
library(car)
#leveneTest(被检验变量~分组变量)
leveneTest(mydata$胃半排空时间~mydata$分组)
leveneTest(mydata$胃半排空时间,mydata$分组)
#莱文方差齐性检验得出的P>0.05,则认为组间方差
#无显著差异。
#本案例的三组间方差齐。

#3、单因素方差分析
#单因素方差分析使用的函数是oneway.test
res1 <- oneway.test(mydata$胃半排空时间~mydata$分组,
            var.equal = TRUE)
res1
#以上单因素方差分析得出P<0.05,
#意味着三组的胃半排空时间时间的均值存在显著差异
#则需要继续进行两两比较

#4、两两比较（基于方差齐）
#两两比较需要用到的程序包是PMCMRplus
#PMCMRplus程序包既可以实现方差齐的两两比较
#也可以实现方差不齐的两两比较
library(PMCMRplus)
#lsdTest是基于方差齐的两两比较方法
mul <- lsdTest(mydata$胃半排空时间~mydata$分组)


0.95*0.95*0.95

mul$p.value

padj <- p.adjust(mul$p.value, method = 'bonferroni')
padj

#溃疡样型和动力障碍样型 、非特异性型之间的胃半排空时间时间
#存在显著差异；而动力障碍样型和非特异性型之间
#无显著差异，P>0.05
#更进一步结合均值
aggregate(x=list(mydata[,3]),
          by = list(mydata[,2]),
          FUN = mean)
#得出溃疡样型的胃半排空时间显著高于动力障碍样型 、非特异性型。





#多变量的单因素方差
#1、正态性检验
for(i in 3:8){
  print(colnames(mydata)[i])
  print(tapply(mydata[,i],
         mydata[,2], 
         shapiro.test))
}

#比较三组间在这"胃半排空时间"、"餐后2小时残留率"
#"NO"  三个变量的差异，可以选择单因素方差分析

#2、描述性统计分析
均值标准差 <- function(x){
  paste0(round(mean(x),2),'±',round(sd(x),2))
}

res2 <- aggregate(x=list(mydata[,3:5]),
          by = list(mydata[,2]),
          FUN = 均值标准差)
write.csv(res2,'res2.csv')

#3、方差齐性检验
leveneTest(mydata$胃半排空时间,mydata$分组)

for(i in 3:5){
  print(colnames(mydata)[i])
  print(leveneTest(mydata[,i]~mydata[,2]))
}
#这"胃半排空时间"\"NO"方差齐
#"餐后2小时残留率"方差不齐



#4、单因素方差分析
oneway.test(mydata$胃半排空时间~mydata$分组,
                    var.equal = TRUE)

oneway.test(mydata$NO~mydata$分组,
            var.equal = TRUE)


oneway.test(mydata$餐后2小时残留率~mydata$分组,
            var.equal = FALSE)


#5、两两比较
#lsd是方差齐的两两比较
res5 <- lsdTest(mydata$NO~mydata$分组)
res5
padj2 <- p.adjust(res5$p.value, method = 'bonferroni')
padj2

#方差不齐的两两比较Tamhane T2两两比较
tamhaneT2Test(mydata$餐后2小时残留率~mydata$分组)

