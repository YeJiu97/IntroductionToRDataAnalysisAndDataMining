####分类汇总####
#分类汇总：分组进行描述性统计分析


#将tbl_df转成普通的df
mydata <- data.frame(mydata)
mydata$性别 <- factor(mydata$性别, levels = c(1,2),
                    labels = c('男', '女'))
mydata$代谢综合征 <- factor(mydata$代谢综合征, levels = c(0,1),
                    labels = c('无', '有'))



#如果不分组，针对全部的418个样本进行描述
#使用的函数是apply
#apply(数据框, 行/列, 函数)
apply(mydata[,c(2,4:14)], 2, mean)

sss <- mydata[,c(2,4:14)]



#如果按照性别分组，分别对男性和女性都进行描述
#使用的函数是aggregate函数
#aggregate(数据框, 分组, 函数)
#aggregate(x = list(数据框), 
#          by = list(分组向量), 
#          FUN = 自带函数或自编函数)


aggregate(x = list(mydata[,c(2,4:14)]),
          by = list(mydata$性别), 
          FUN = mean)



#如果按照代谢综合征分组，分别对有和无都进行描述
aggregate(x = list(mydata[,c(2,4:14)]),
          by = list(mydata$代谢综合征), 
          FUN = mean)


#多分组分类汇总
aggregate(x = list(mydata[,c(2,4:14)]),
          by = list(mydata$代谢综合征, mydata$性别), 
          FUN = mean)



#自变函数的分类汇总
fun1 <- function(x){
  paste0(round(mean(x),2), '±', round(sd(x),2))
}
fun1(mydata$年龄)

res1 <- aggregate(x = list(mydata[,c(2,4:14)]),
          by = list(mydata$代谢综合征, mydata$性别), 
          FUN = fun1)

write.csv(res1, 'res1.csv')


#服从正态分布的数据用：均值±标准差



#非正态分布，一般用：中位数（下四分位数~上四分位数）

fun2 <- function(x){
  paste0(round(median(x),2), '(', 
         round(quantile(x,prob = 0.25),2), '~', 
         round(quantile(x,prob = 0.75),2), ')')
}

fun2(mydata$年龄)

res2 <- aggregate(x = list(mydata[,c(2,4:14)]),
          by = list(mydata$代谢综合征, mydata$性别), 
          FUN = fun2)
write.csv(res2, 'res2.csv')




























