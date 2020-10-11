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

big_data_rates <- fread("big_data_rates.csv", header = T)
big_data_change <- fread("big_data_change.csv", header = T)

change_all <- big_data_change[AGE_GROUP == "All ages"]
change_19 <- big_data_change[AGE_GROUP == "0-19"]
change_39 <- big_data_change[AGE_GROUP == "20-39"]
change_59 <- big_data_change[AGE_GROUP == "40-59"]
change_60 <- big_data_change[AGE_GROUP == "60+"]

#Regressions

# Overall literacy rate vs. migration rate by age groups 
lit_mig_all <- lm(data=change_all, LIT_RATE_T ~ MIG_RATE_T)
lit_mig_19 <- lm(data=change_19, LIT_RATE_T ~ MIG_RATE_T)
lit_mig_39 <- lm(data=change_39, LIT_RATE_T ~ MIG_RATE_T)
lit_mig_59 <- lm(data=change_59, LIT_RATE_T ~ MIG_RATE_T)
lit_mig_60 <- lm(data=change_60, LIT_RATE_T ~ MIG_RATE_T)

# Robustness checks
outliers <- boxplot(change_all$MIG_RATE_T)$out
outliers_index <- which(change_all$MIG_RATE_T %in% outliers)
temp_all <- change_all[!(outliers_index)]
outliers2 <- boxplot(temp_all$LIT_RATE_T)$out
outliers_index2 <- which(temp_all$LIT_RATE_T %in% outliers2)
robust_all <- temp_all[!(outliers_index2)]
ggplot(robust_all, aes(x=MIG_RATE_T, y=LIT_RATE_T)) + 
  geom_point() + geom_text(aes(label=STATE))
robust_all_2d <- robust_all[!(STATE == "DAMAN & DIU")]
robust_lit_mig_all <- lm(data=robust_all_2d, LIT_RATE_T ~ MIG_RATE_T)

outliers <- boxplot(change_19$MIG_RATE_T)$out
outliers_index <- which(change_19$MIG_RATE_T %in% outliers)
temp_19 <- change_19[!(outliers_index)]
outliers2 <- boxplot(temp_19$LIT_RATE_T)$out
outliers_index2 <- which(temp_19$LIT_RATE_T %in% outliers2)
robust_19 <- temp_19[!(outliers_index2)]
ggplot(robust_19, aes(x=MIG_RATE_T, y=LIT_RATE_T)) + 
  geom_point() + geom_smooth(method = "lm")
robust_19_2d <- robust_19[!(STATE == "GOA")]
robust_lit_mig_19 <- lm(data=robust_19_2d, LIT_RATE_T ~ MIG_RATE_T)
# Not robust if Goa is an outlier

outliers <- boxplot(change_39$MIG_RATE_T)$out
outliers_index <- which(change_39$MIG_RATE_T %in% outliers)
temp_39 <- change_39[!(outliers_index)]
outliers2 <- boxplot(temp_39$LIT_RATE_T)$out
outliers_index2 <- which(temp_39$LIT_RATE_T %in% outliers2)
robust_39 <- temp_39[!(outliers_index2)]
ggplot(robust_39, aes(x=MIG_RATE_T, y=LIT_RATE_T)) + 
  geom_point() + geom_smooth(method = "lm") + geom_text(aes(label=STATE))
robust_39_2d <- robust_39[!(STATE == "MIZORAM")]
robust_lit_mig_39 <- lm(data=robust_39_2d, LIT_RATE_T ~ MIG_RATE_T)
# Not robust if Mizoram is an outlier

outliers <- boxplot(change_59$MIG_RATE_T)$out
outliers_index <- which(change_59$MIG_RATE_T %in% outliers)
temp_59 <- change_59[!(outliers_index)]
outliers2 <- boxplot(temp_59$LIT_RATE_T)$out
outliers_index2 <- which(temp_59$LIT_RATE_T %in% outliers2)
robust_59 <- temp_59[!(outliers_index2)]
ggplot(robust_59, aes(x=MIG_RATE_T, y=LIT_RATE_T)) + 
  geom_point() + geom_smooth(method = "lm") 
robust_lit_mig_59 <- lm(data=robust_59, LIT_RATE_T ~ MIG_RATE_T)
#Not robust?

outliers <- boxplot(change_60$MIG_RATE_T)$out
outliers_index <- which(change_60$MIG_RATE_T %in% outliers)
temp_60 <- change_60[!(outliers_index)]
outliers2 <- boxplot(temp_60$LIT_RATE_T)$out
outliers_index2 <- which(temp_60$LIT_RATE_T %in% outliers2)
robust_60 <- temp_60[!(outliers_index2)]
ggplot(robust_60, aes(x=MIG_RATE_T, y=LIT_RATE_T)) + 
  geom_point() + geom_smooth(method = "lm") + geom_text(aes(label=STATE))
outlier_states <- c("DAMAN & DIU", "ARUNACHAL PRADESH")
robust_60_2d <- robust_60[!(STATE%in%outlier_states)]
robust_lit_mig_60 <- lm(data=robust_60, LIT_RATE_T ~ MIG_RATE_T)
#Robust

# Migrant literacy rate vs. migration rate by age groups 
miglit_mig_all <- lm(data=big_data_change[AGE_GROUP == "All ages"], MIG_LIT_RATE_T ~ MIG_RATE_T)


# Literacy rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Literacy Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Literacy Rate")

# Migrant literacy rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=MIG_LIT_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Migrant Literacy Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Migrant Literacy Rate")

# Primary edu rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_PR_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Primary Grad Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Primary School Grad Rate")


# Middle school edu rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_MI_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Middle School Grad Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Middle School Grad Rate")

# Matric school edu rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_MA_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Matric Grad Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Matric School Grad Rate")

# High school edu rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_HS_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in High School Grad Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ High School Grad Rate")

# Technical degree  rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_TD_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm")

# Graduate degree  rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=LIT_RATE_GR_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm")

# Migrant below matric rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=MIG_BS_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm") +
  ggtitle("Changes in Migrant Primary School Grad Rate vs. Migration Rate by Age Group (1991-2001)") +
  xlab ("Δ Migration Rate") +
  ylab("Δ Migrant Primary School Grad Rate")

# Migrant matric rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=MIG_MA_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm")

# Migrant technical degree rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=MIG_TD_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm")

# Migrant graduate degree rate vs. migration rate by age groups 
ggplot(data=big_data_change, aes(x=MIG_RATE_T, y=MIG_GR_RATE_T)) +
  geom_point() + 
  facet_grid(.~AGE_GROUP) + 
  geom_smooth(method = "lm")

# Robustness checks 
lit_mig_all <- lm(data=big_data_change[AGE_GROUP == "All ages"], LIT_RATE_T ~ MIG_RATE_T)


