data <- Measurement_summary$Measurement.date
location <- Measurement_summary$Address
PM10 <- Measurement_summary$PM10
PM2.5 <- Measurement_summary$PM2.5

df_info <- data.frame(data,location,PM10,PM2.5)
View(df_info)
df_info

str(Measurement_summary)

max(PM10) # row 16701
max(PM2.5) # row 1602
mean(PM10)
mean(df_info[,3])
mean(PM2.5)
mean(df_info[,4])

df_info[16701,3]
df_info[1602,4]
df_info[16701,]
df_info[1602,]

library(xlsx)
write.xlsx(df_info,'df_info.xlsx')


str(df_info)
df_info$data <- as.Date(df_info$data)
y2017 <- subset(df_info, data >= "2017-01-01 0:00" & data < "2017-01-02 0:00")
y2018 <- subset(df_info, data >= "2018-01-01 0:00" & data < "2018-01-02 0:00")
y2019 <- subset(df_info, data >= "2019-01-01 0:00" & data < "2019-01-02 0:00")
