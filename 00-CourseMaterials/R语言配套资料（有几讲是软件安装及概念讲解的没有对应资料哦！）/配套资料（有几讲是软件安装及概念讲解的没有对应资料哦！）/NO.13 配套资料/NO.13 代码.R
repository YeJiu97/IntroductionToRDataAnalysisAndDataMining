#循环：规律性的重复操作。
#举例1：针对不同的变量（向量）进行同样的重复检验——针对向量的循环
#举例2：针对样本进行同样的重复检验——针对样本
#举例3：针对向量中的元素同样的重复检验——针对元素

#R语言实现循环的代码是for

#举例3：针对向量中的元素同样的重复检验——针对元素
#班上有16名学生，期中考试成绩的向量如下：
score <- c(95,63,52,85,62,45,32,97,51,48,72,56,34,82,96,100)
length(score)
score

#向量中提取或者调用期中一个元素的代码：
score[13]
score[8]

#现在需要根据>=60为及格这个标准，将16个孩子的考试成绩的及格
#情况判断出来。
i in 1:16  #i代表任意一个学生
score[i]  #代表任意一个学生的成绩

#for循环的代码结构
for(i in 范围){
  循环操作的内容
}
  
  
  
#循环 
for(i in 1:16){
  ifelse(score[i] >= 60, '及格', '不及格')
}

#以上循环展开的状况
ifelse(score[1] >= 60, '及格', '不及格')
ifelse(score[2] >= 60, '及格', '不及格')
ifelse(score[3] >= 60, '及格', '不及格')
ifelse(score[4] >= 60, '及格', '不及格')
ifelse(score[5] >= 60, '及格', '不及格')
ifelse(score[6] >= 60, '及格', '不及格')
ifelse(score[7] >= 60, '及格', '不及格')
ifelse(score[8] >= 60, '及格', '不及格')
ifelse(score[9] >= 60, '及格', '不及格')
ifelse(score[10] >= 60, '及格', '不及格')
ifelse(score[11] >= 60, '及格', '不及格')
ifelse(score[12] >= 60, '及格', '不及格')
ifelse(score[13] >= 60, '及格', '不及格')
ifelse(score[14] >= 60, '及格', '不及格')
ifelse(score[15] >= 60, '及格', '不及格')
ifelse(score[16] >= 60, '及格', '不及格')



#以下循环等价于以上16个单独的代码
for(i in 1:16){
  print(ifelse(score[i] >= 60, '及格', '不及格'))
}




#举例1：针对不同的变量（向量）（列）进行同样的重复检验——针对向量的循环
mydata <- as.data.frame(mydata)
mean(mydata$BMI)
mean(mydata$LDL)

#for循环的代码结构
for(i in 范围){
  循环操作的内容
}
i in c(2:3, 5:9)   #i代表数据框中的列
#数据框中查询元素需要行、列两个参数
#数据框[行, 列]
mydata[12,2]
mydata[ ,2]
mydata[12 ,]


####循环语句计算均值#####
for(i in c(2:3, 5:9)){
  print(colnames(mydata)[i])
  print(mean(mydata[,i]))
}

#错误代码
for(i in c(2:3, 5:9)){
  +   print(colnames(mydata[,i]))
  +   print(mean(mydata[,i]))
  + }
###以上代码错误

colnames(mydata)

####循环语句计算标准差#####
for(i in c(2:3, 5:9)){
  print(colnames(mydata)[i])
  print(sd(mydata[,i]))
}

####循环语句计算中位数#####
for(i in c(2:3, 5:9)){
  print(colnames(mydata)[i])
  print(median(mydata[,i]))
}

####循环语句进行正态性检验#####
for(i in c(2:3, 5:9)){
  print(colnames(mydata)[i])
print(shapiro.test(mydata[,i]))
}


#举例2：针对样本(行)进行同样的重复检验——针对样本
# if else 仅仅只能针对单个元素或样本，而不能针对向量
gender <- '男'
height <- 185
gender
height
#判断身高是否达标的条件是：
#1、女>=160达标
#2、男>=170达标

if(gender == '男'){
  print(ifelse(height >= 170, '达标', '不达标'))
}else{
  print(ifelse(height >= 160, '达标', '不达标'))
}


mydata$性别 <- factor(mydata$性别, 
                    levels = c(1,2),labels = c('男', '女'))



if(mydata$性别 == '男'){
  print(ifelse(mydata$身高 >= 170, '达标', '不达标'))
}else{
  print(ifelse(mydata$身高 >= 160, '达标', '不达标'))
}



if(mydata$性别[i] == '男'){
  print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
}else{
  print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
}


for(i in 1:149){
  if(mydata$性别[i] == '男'){
    print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
  }else{
    print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
  }
}










