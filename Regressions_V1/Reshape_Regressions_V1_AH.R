install.packages("data.table")
install.packages("tidyverse")
install.packages("ggthemes")
install.packages("stargazer")
install.packages("doBy")
library(data.table)
library(tidyverse)
library(ggthemes)
library(stargazer)
library(doBy)
setwd("~/Dropbox/Oeconomica Education Migration Group/Data_ready_to_use")

mig_1991 <- fread("1991_D5D7_useful.csv", header = T)
tot_1991 <- fread("1991_C2_useful.csv", header = T)
mig_2001 <- fread("2001_D4_useful.csv", header = T)
tot_2001 <- fread("2001_C8_useful.csv", header = T)

# all 1991 data (total edu rates and migrant rates)
data_1991 <- cbind(tot_1991, mig_1991[,3:15])
# all 2001 data (total edu rates and migrant rates)
data_2001 <- cbind(tot_2001, mig_2001[,6:29])

write.csv(data_1991, file = "data_1991.csv")
write.csv(data_2001, file = "data_2001.csv")

newdata_1991 <- fread("data_1991.csv", header = T)
newdata_2001 <- fread("data_2001.csv", header = T)

View(rbind(newdata_1991, newdata_2001))
# macro data table w/ data from all years, tot, and mig data
big_data <- dplyr::bind_rows(list("1991"=newdata_1991, "2001"=newdata_2001), .id = 'YEAR')
write.csv(big_data, file = "big_data.csv")

# Re-run 1
big_data <- fread("big_data.csv", header = T)

# Summary statistics
# stargazer(big_data, type = "latex", style = "aer", digits = 0, 
          # covariate.labels=c(), out = "big_data_ss.tex")
# big_data %>% filter(YEAR == "2001") %>% summaryBy(LIT_T/POP_T ~ STATE, FUN = c(length, mean), na.rm=TRUE)

big_data[, MIG_RATE_T := MIG_T/POP_T, by = V1]
big_data[, LIT_RATE_T := LIT_T/POP_T, by = V1]
write.csv(big_data, file = "big_data_3.csv")
data_91 <- big_data %>% filter(YEAR == 1991)
data_01 <- big_data %>% filter(YEAR == 2001)
MIG_CHANGE <- select(data_01, MIG_RATE_T) - select(data_91, MIG_RATE_T) 
LIT_CHANGE <- select(data_01, LIT_RATE_T) - select(data_91, LIT_RATE_T) 
temp <- cbind(MIG_CHANGE, LIT_CHANGE)
big_data_2 <- cbind(big_data, temp)
write.csv(big_data_2, file = "big_data_2.csv")

#Re-runs after first iteration  

big_data[, LIT_RATE_M := LIT_M/POP_M, by = V1]
big_data[, LIT_RATE_F := LIT_F/POP_F, by = V1]
big_data[, LIT_RATE_PR_T := LIT_PR_T/POP_T, by = V1]
big_data[, LIT_RATE_PR_M := LIT_PR_TM/POP_M, by = V1]
big_data[, LIT_RATE_PR_F := LIT_PR_F/POP_F, by = V1]

# Regressions
mig_lit <- lm(LIT_T/POP_T ~ MIG_T/POP_T, data = big_data)
summary(mig_lit)
litq3 <- quantile(big_data$LIT_T/big_data$POP_T, probs=0.75)
litq1 <- quantile(big_data$LIT_T/big_data$POP_T, probs=0.25)
iqr1 <- 1.5*(litq3 - litq1)
lit_rate1 <- big_data[LIT_T/POP_T < (litq3 + iqr1) & LIT_T/POP_T > (litq1 + iqr1)] 
migq3 <- quantile(big_data$MIG_T/big_data$POP_T, probs=0.75)
migq1 <- quantile(big_data$MIG_T/big_data$POP_T, probs=0.25)
iqr2 <- 1.5*(migq3 - migq1)
mig_rate_1 <- big_data[MIG_T/POP_T < (migq3 + iqr2) & MIG_T/POP_T > (migq1 + iqr2)] 

mig_lit_2 <- lm(lit_rate1$LIT_T/lit_rate1$POP_T ~ mig_rate_1$MIG_T/mig_rate_1$POP_T)

mig_lit_1991 <- lm(LIT_T/POP_T ~ MIG_T/POP_T, data = data_91)
summary(mig_lit_1991)

mig_lit_2001 <- lm(LIT_T/POP_T ~ MIG_T/POP_T, data = data_01)
summary(mig_lit_2001)

mig_lit_rate <- lm(LIT_RATE_T ~ MIG_RATE_T, data = big_data_2)
summary(mig_lit_rate)
big_data_2 %>% ggplot(aes(x=MIG_RATE_T, y = LIT_RATE_T, col = STATE)) + geom_point(show.legend = FALSE)

mig_lit_change <- lm(LIT_RATE_CHANGE_T ~ MIG_RATE_CHANGE_T, data = big_data_2)
summary(mig_lit_change)
big_data_2 %>% ggplot(aes(x=MIG_RATE_CHANGE_T, y = LIT_RATE_CHANGE_T, col = STATE)) + geom_point(show.legend = FALSE)


# Literacy rates by percent migrants BY AGE GROUP
big_data %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(AGE_GROUP~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Literacy Rate") + 
  ggtitle("Literacy Rates by Percent Migrants") 

# Primary school graduatation rate by percent migrants BY AGE GROUP
big_data %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_PR_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(AGE_GROUP~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Primary School Graduation Rate") + 
  ggtitle("Primary School Graduation Rates by Percent Migrants") 

# High school graduatation rate by percent migrants BY AGE GROUP
big_data %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_HS_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(AGE_GROUP~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("High School Graduation Rate") + 
  ggtitle("High School Graduation Rates by Percent Migrants") 

# College grad rate by percent migrants BY AGE GROUP
big_data %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_GR_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(AGE_GROUP~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("College Graduation Rate") + 
  ggtitle("College Graduation Rates by Percent Migrants") 







# Literacy rates by percent migrants (stacked horizontally)
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Literacy Rate") + 
  ggtitle("Literacy Rates by Percent Migrants") 

# Literacy rates by percent migrants (stacked vertically)
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Literacy Rate") + 
  ggtitle("Literacy Rates by Percent Migrants") + 
  facet_grid(YEAR~.)

# Primary school graduatation rate by percent migrants 
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_PR_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Primary School Graduation Rate") + 
  ggtitle("Primary School Graduation Rates by Percent Migrants") 

# Middle school graduatation rate by percent migrants 
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_MI_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Middle School Graduation Rate") + 
  ggtitle("Middle School Graduation Rates by Percent Migrants") 

# High school graduatation rate by percent migrants 
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_HS_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("High School Graduation Rate") + 
  ggtitle("High School Graduation Rates by Percent Migrants") 

# Matric graduatation rate by percent migrants 
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_MA_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("Matric Graduation Rate") + 
  ggtitle("Matric Graduation Rates by Percent Migrants") 

# College grad rate by percent migrants 
big_data %>% filter(AGE_GROUP == "All ages") %>% ggplot(aes(x=MIG_T/POP_T, y=LIT_GR_T/POP_T, col = STATE)) +
  geom_point(show.legend = FALSE) +
  facet_grid(.~YEAR) +
  xlab("Percent migrants in population") + 
  ylab("College Graduation Rate") + 
  ggtitle("College Graduation Rates by Percent Migrants") 

