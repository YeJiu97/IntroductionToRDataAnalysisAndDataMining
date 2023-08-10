#######NO.14讲代码####
mydata <- as.data.frame(mydata)
##1、将循环运算的结果导成表格形式
ifelse(mydata$BMI < 24 & mydata$BMI >=18.5,
       '正常', '不正常')
mydata$BMIlevel <- ifelse(mydata$BMI < 24 & mydata$BMI >=18.5,
                          '正常', '不正常')
#将R运算结果导出为csv格式
write.csv(mydata, 'mydata.csv')
getwd()


#男性>=170  女性>=160 达标

for(i in 1:149){
  if(mydata$性别[i] == 1){
    print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
  }else{
    print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
  }
}


###以下是尝试1：
  mydata$是否达标 <- for(i in 1:149){
  if(mydata$性别[i] == 1){
    print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
  }else{
    print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
  }
}
##以上操作是错误的
  
  
###以下是尝试2：
  for(i in 1:149){
    dd <- if(mydata$性别[i] == 1){
      print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
    }else{
      print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
    }
  }

  dd
##以上操作也是错误的


  
  

#循环运算结果的输出
身高达标 <- NULL
for(i in 1:149){
  dd <- if(mydata$性别[i] == 1){
    print(ifelse(mydata$身高[i] >= 170, '达标', '不达标'))
  }else{
    print(ifelse(mydata$身高[i] >= 160, '达标', '不达标'))
  }
  身高达标 <- rbind(身高达标, dd)
}
  
身高达标
mydata <- data.frame(mydata, 身高达标)
write.csv(mydata, 'mydata.csv')
  
  
