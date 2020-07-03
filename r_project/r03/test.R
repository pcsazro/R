library(readxl)
raw_insurance <- read.csv('states.csv')
usa_insurance <- as.data.frame(raw_insurance)
head(usa_insurance)

usa_insurance_nums <- usa_insurance %>% 
  select(pid,Uninsured.Rate..2010.,Uninsured.Rate..2015.,,
         Health.Insurance.Coverage.Change..2010.2015.,Employer.Health.Insurance.Coverage..2015.,
         Marketplace.Health.Insurance.Coverage..2016.,Average.Monthly.Tax.Credit..2016.,
         Medicaid.Enrollment..2013.,Medicaid.Enrollment..2016.,Medicaid.Enrollment.Change..2013.2016.,
         Medicare.Enrollment..2016.)
head(usa_insurance_nums)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Uninsured.Rate..2015.)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Uninsured.Rate.Change..2010.2015.)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Health.Insurance.Coverage.Change..2010.2015.)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Medicare.Enrollment..2016.)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Uninsured.Rate..2015.)
cor.test(usa_insurance_nums$Uninsured.Rate..2010.,usa_insurance_nums$Uninsured.Rate..2015.)
cor.test(usa_insurance_nums$Medicaid.Enrollment..2013., usa_insurance_nums$Medicaid.Enrollment..2016.)

library(corrplot)

table(is.na(usa_insurance_nums))

usa_insurance_nums$Medicaid.Enrollment..2013. <- ifelse(is.na(usa_insurance_nums$Medicaid.Enrollment..2013.), 0, usa_insurance_nums$Medicaid.Enrollment..2013.)
usa_insurance_nums$Medicaid.Enrollment.Change..2013.2016. <- ifelse(is.na(usa_insurance_nums$Medicaid.Enrollment.Change..2013.2016.), 0, usa_insurance_nums$Medicaid.Enrollment.Change..2013.2016.)

usa_insu <- usa_insurance_nums %>% filter(!is.na(Medicaid.Enrollment..2013.) & !is.na(Medicaid.Enrollment.Change..2013.2016.))
cor_insu <- cor(usa_insu)
corrplot(cor_insu,  tl.srt = 30, type = "lower")
