#####################################################
# 字符串变量的整理
## 什么是字符串：只需要使用"" 或者 ''，那么就是字符串
## 5 是一个数字，"5" 则是一个字符串

x <- 6
typeof(x)

x_str <- "6"
typeof(x_str)

x_vector <- c(1, 2, 3, 4, 5)
typeof(x_vector)

x_vector_2 <- c(1, 2, "3", "4", "5")
typeof(x_vector_2)

library(readxl)
data_str <- read_xlsx("string_data.xlsx")
data_str

# 求一下字符串的长度
nchar(data_str$职业)

# 查找：字符串的各个元素中是否包含了某一个字符/目标字符
grep("辛辣", data_str$饮食偏好)
target_vector <- grep("辛辣", data_str$饮食偏好)
target_vector
data_str[target_vector,]

# 还可以使用grepl来进行查询
grepl("辛辣", data_str$饮食偏好)
as.numeric(grepl("辛辣", data_str$饮食偏好))
data_str$是否辛辣 <- as.numeric(grepl("辛辣", data_str$饮食偏好)) # 添加一个新的变量
data_str$是否辛辣

data_str$是否高脂肪饮食猪肉 <- as.numeric(grepl("高脂肪饮食猪肉", data_str$饮食偏好))
data_str$是否高脂肪饮食猪肉

data_str$是否牛肉 <- as.numeric(grepl("牛肉", data_str$饮食偏好))
data_str$是否牛肉

data_str$是否动物内脏 <- as.numeric(grepl("动物内脏", data_str$饮食偏好))
data_str$是否动物内脏

data_str$是否高盐 <- as.numeric(grepl("高盐", data_str$饮食偏好))
data_str$是否高盐

data_str$是否粗纤维饮食蔬菜 <- as.numeric(grepl("粗纤维饮食蔬菜", data_str$饮食偏好))
data_str$是否粗纤维饮食蔬菜

data_str$是否腌制食品 <- as.numeric(grepl("腌制食品", data_str$饮食偏好))
data_str$是否腌制食品

data_str$是否喜油腻 <- as.numeric(grepl("喜油腻", data_str$饮食偏好))
data_str$是否喜油腻

data_str$是否喜煎炸 <- as.numeric(grepl("喜煎炸", data_str$饮食偏好))
data_str$是否喜煎炸

data_str$是否水果 <- as.numeric(grepl("水果", data_str$饮食偏好))
data_str$是否水果

data_str$是否甜食 <- as.numeric(grepl("甜食", data_str$饮食偏好))
data_str$是否甜食

data_str$是否无特殊偏嗜 <- as.numeric(grepl("无特殊偏嗜", data_str$饮食偏好))
data_str$是否无特殊偏嗜

## 提取
data_str$出生年份 <- substr(data_str$身份证号, 7, 10)  # 将7~10，包括7和10
str(data_str)

data_str$出生年份 <- as.numeric(data_str$出生年份)
str(data_str$出生年份)

## 替换/删除
### gsub("被替换的内容", "替换内容", 字符串)
gsub('[0-9]', '', data_str$姓名编号)

data_str$姓名 <- gsub('[0-9]', '', data_str$姓名编号)
data_str$姓名


gsub('[^0-9]', '', data_str$姓名编号)

data_str$编号 <- gsub('[^0-9]', '', data_str$姓名编号)
data_str$编号

### substr(字符串, 开始位置, 结束位置)
data_str$隐匿年份 <- data_str$身份证号
substr(data_str$隐匿年份, 7, 10) <- "XXXX"
data_str$隐匿年份


### 黏贴
#### paste(变量1, 变量2, sep = "❤)
data_str$姓名编号_新 <- paste(data_str$姓名, data_str$编号, sep = "❤")
data_str$姓名编号_新







########################################################
# 日期变量的整理
a <- c(1, 2, 3, 4)  # 数值型向量
b <- c("上海", "北京", "广州", "深圳", )  # 字符型向量
d <- c(TRUE, TRUE, FALSE, FALSE )  # 逻辑型向量

# 日期向量  YYYY-mm-dd                    DATE
# 时间向量  YYYY-mm-dd HH:MM:SS           POSIXct

date_01 <- c("2022-11-22", "2022-11-01", "2022-11-03")  # 日期向量
date_01 <- as.Date(date_01)  # 转换为日期

# 只有转换为Date才能够计算日期差
date_02 <- c('2022-11-22 17:06:23', '2022-11-01 12:35:29', '2022-11-03 21:18:09')
date_02 <- as.POSIXct(date_02)

# 加载
library("lubridate")

year(date_01)
month(date_01)
day(date_01)
quarter(date_01)

year(date_02)
month(date_02)
day(date_02)
quarter(date_02)
hour(date_02)
minute(date_02)
second(date_02)

# 加减法
date_01
date_03 <- date_01 + 3  # 向量中的每一个日期都增加了3天
date_03

date_02
date_04 <- date_02 + 4  # 向量中的每一个日期都增加了4秒
date_04

# 开始进行操作
View(date_data)
str(date_data)

# 使用 lubridate 程序包中的 ymd 函数将变量类型改为 Date
str(date_data$入院日期)
ymd(date_data$入院日期)
str(ymd(date_data$入院日期))
date_data$入院日期 <- ymd(date_data$入院日期)
str(date_data$入院日期)

date_data$手术日期 <- ymd(date_data$手术日期)

# 生成正确的时间变量
date_data$手术开始_完整时间 <- paste(date_data$手术日期, 
                             date_data$手术开始时间, spe = " ")
# 同理，手术完成的时间
date_data$手术结束_完整时间 <- paste(date_data$手术日期, date_data$手术结束时间, sep = " ")
date_data$手术结束_完整时间

# class()检测
class(date_data$手术开始_完整时间)
class(date_data$手术结束_完整时间)

# 开始修改成正确的格式
date_data$出院日期 <- ymd(date_data$出院日期)
date_data$手术开始_完整时间 <- ymd_hms(date_data$手术开始_完整时间)
date_data$手术结束_完整时间 <- ymd_hms(date_data$手术结束_完整时间)
str(date_data)

# 计算时间差
date_data$手术等待时间 <- difftime(date_data$手术日期, 
                             date_data$入院日期, 
                             units = "days")
date_data$手术等待时间
mean(date_data$手术等待时间)


# 计算手术的时长
date_data$手术时长 <- difftime(date_data$手术结束_完整时间,
                           date_data$手术开始_完整时间, units = "hours")
date_data$手术时长
mean(date_data$手术时长)


# 导出为csv文件
write.csv(x = date_data, file = "date_data_clean.csv")






#######################################################
# 缺失值处理
# 创建缺失值
score <- c(92, 91, NA, 62, 85, 88, NA, 92, NA)
score

# 缺失值数量计算
## 缺失值数量计算使用summary()函数
summary(score)


## 计算这一个位置的值是否是NA
is.na(score)

## 使用which函数查找缺失值的位置
which(is.na(score))

## 忽略缺失值
na.omit(score)

## 计算
mean(score)
mean(na.omit(score))


## 缺失值较多
# 生成含有较多缺失值的数据
set.seed(1)
data <- data.frame(
  x = rnorm(100),
  y = rnorm(100),
  z = rep(NA, 100)  # 生成全部为NA的变量
)

# 计算每个变量的缺失值比例
missing_percentage <- colMeans(is.na(data))

# 根据缺失值比例删除变量
data_cleaned <- data[, missing_percentage < 0.8]


# 导入数据集进行实操
library(readxl)
missing_df <- read_xls("missing_value_data.xls")

# 检查数据集中的missing value
summary(missing_df)

# 进行可视化
library(ggplot2)

# 创建数据框来存储缺失值信息
missing_summary <- data.frame(
  Variable = names(missing_df),
  Missing_Percentage = colMeans(is.na(missing_df)) * 100
)

# 创建条形图
bar_plot <- ggplot(missing_summary, aes(x = Variable, y = Missing_Percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Missing Values Summary", x = "Variable", y = "Missing Percentage")

# 显示条形图
print(bar_plot)
