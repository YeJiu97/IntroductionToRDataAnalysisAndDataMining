#####交叉表卡方检验##
#1、导入SPSS格式的数据
#选择Hmisc这个程序包中的spss.get函数导入数据
library(Hmisc)
mydata <- spss.get('NO.19 配套数据.sav',
                   use.value.labels = TRUE)

#2、交叉表卡方
#交叉表卡方检验使用的是gmodels程序包中的CrossTable函数
library(gmodels)
#性别、糖尿病病史的交叉卡方
table(mydata$性别, mydata$糖尿病病史)
tab1 <- table(mydata$糖尿病病史, mydata$性别)
a1 <- CrossTable(tab1, chisq = TRUE,
           expected = TRUE,
           fisher = TRUE)
#a1$t  #查看交叉表
#a1$prop.col  #查看占比
#a1$chisq   #查看卡方检验的结果
#paste0(a1$t, '(', round(a1$prop.col*100,2),'%)')
#以下代码均为标准论文表格的制作
res1 <- data.frame(matrix(paste0(a1$t, '(', round(a1$prop.col*100,2),'%)'), 2, 2))
colnames(res1) <- c('男', '女')
rownames(res1) <- c('否', '是')
res1$var <- c('糖尿病病史', 'NA')
list1 <- a1$chisq
list1 <- do.call('rbind',list1)
res1$chisq <- c(list1[1,1],'NA')
res1$p <- c(list1[3,1],'NA')


#性别、腰围的交叉表卡方
table(mydata$腰围, mydata$性别)
tab2 <- table(mydata$腰围, mydata$性别)
a2 <- CrossTable(tab2, chisq = TRUE,
                 expected = TRUE,
                 fisher = TRUE)
res2 <- data.frame(matrix(paste0(a2$t, '(', round(a2$prop.col*100,2),'%)'), 2, 2))
colnames(res2) <- c('男', '女')
rownames(res2) <- c('正常', '异常')
res2$var <- c('腰围', 'NA')
list2 <- a2$chisq
list2 <- do.call('rbind',list2)
res2$chisq <- c(list2[1,1],'NA')
res2$p <- c(list2[3,1],'NA')


#性别、血压的交叉表卡方
table(mydata$血压, mydata$性别)
tab3 <- table(mydata$血压, mydata$性别)
a3 <- CrossTable(tab3, chisq = TRUE,
                 expected = TRUE,
                 fisher = TRUE)
res3 <- data.frame(matrix(paste0(a3$t, '(', round(a3$prop.col*100,2),'%)'), 2, 2))
colnames(res3) <- c('男', '女')
rownames(res3) <- c('正常', '异常')
res3$var <- c('血压', 'NA')
list3 <- a3$chisq
list3 <- do.call('rbind',list3)
res3$chisq <- c(list3[1,1],'NA')
res3$p <- c(list3[3,1],'NA')


#性别、HDL的交叉表卡方
table(mydata$HDL, mydata$性别)
tab4 <- table(mydata$HDL, mydata$性别)
a4 <- CrossTable(tab4, chisq = TRUE,
                 expected = TRUE,
                 fisher = TRUE)
res4 <- data.frame(matrix(paste0(a4$t, '(', round(a4$prop.col*100,2),'%)'), 2, 2))
colnames(res4) <- c('男', '女')
rownames(res4) <- c('正常', '异常')
res4$var <- c('HDL', 'NA')
list4 <- a4$chisq
list4 <- do.call('rbind',list4)
res4$chisq <- c(list4[1,1],'NA')
res4$p <- c(list4[3,1],'NA')


#合并所有结果
final <-rbind(res1, res2,res3,res4)
write.csv(final, 'final.csv')




#性别、代谢综合征的交叉表卡方
table(mydata$代谢综合征, mydata$性别)
tab5 <- table(mydata$代谢综合征, mydata$性别)
a5 <- CrossTable(tab5, chisq = TRUE,
                 expected = TRUE,
                 fisher = TRUE)
res5 <- data.frame(matrix(paste0(a5$t, '(', round(a5$prop.col*100,2),'%)'), 2, 2))
colnames(res5) <- c('男', '女')
rownames(res5) <- c('正常', '异常')
res5$var <- c('代谢综合征', 'NA')
list5 <- a5$chisq
list5 <- do.call('rbind',list5)
res5$chisq <- c(list5[1,1],'NA')
res5$p <- c(list5[3,1],'NA')










