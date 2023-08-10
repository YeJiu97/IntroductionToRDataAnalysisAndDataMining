age <- c(11, 18, 30, 45)
BMI <- c(18.4, 21.2, 28.6, 22.7)
cor.test(age, BMI)

plot(age, BMI)

install.packages("rms")  # 安装rms包

library(rms)
