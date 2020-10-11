install.packages("data.table")
install.packages("tidyverse")
library(data.table)
library(tidyverse)
setwd("~/Dropbox/Oeconomica Education Migration Group/Data_ready_to_use")

big_data <- fread("big_data.csv", header = T)

# Converting pop counts into rates 
big_data[, LIT_RATE_T := LIT_T/POP_T, by = V1]
big_data[, LIT_RATE_M := LIT_M/POP_M, by = V1]
big_data[, LIT_RATE_F := LIT_F/POP_F, by = V1]
big_data[, LIT_RATE_PR_T := LIT_PR_T/POP_T, by = V1]
big_data[, LIT_RATE_PR_M := LIT_PR_M/POP_M, by = V1]
big_data[, LIT_RATE_PR_F := LIT_PR_F/POP_F, by = V1]
big_data[, LIT_RATE_MI_T := LIT_MI_T/POP_T, by = V1]
big_data[, LIT_RATE_MI_M := LIT_MI_M/POP_M, by = V1]
big_data[, LIT_RATE_MI_F := LIT_MI_F/POP_F, by = V1]
big_data[, LIT_RATE_MA_T := LIT_MA_T/POP_T, by = V1]
big_data[, LIT_RATE_MA_M := LIT_MA_M/POP_M, by = V1]
big_data[, LIT_RATE_MA_F := LIT_MA_F/POP_F, by = V1]
big_data[, LIT_RATE_HS_T := LIT_HS_T/POP_T, by = V1]
big_data[, LIT_RATE_HS_M := LIT_HS_M/POP_M, by = V1]
big_data[, LIT_RATE_HS_F := LIT_HS_F/POP_F, by = V1]
big_data[, LIT_RATE_NT_T := LIT_NT_T/POP_T, by = V1]
big_data[, LIT_RATE_NT_M := LIT_NT_M/POP_M, by = V1]
big_data[, LIT_RATE_NT_F := LIT_NT_F/POP_F, by = V1]
big_data[, LIT_RATE_TD_T := LIT_TD_T/POP_T, by = V1]
big_data[, LIT_RATE_TD_M := LIT_TD_M/POP_M, by = V1]
big_data[, LIT_RATE_TD_F := LIT_TD_F/POP_F, by = V1]
big_data[, LIT_RATE_GR_T := LIT_GR_T/POP_T, by = V1]
big_data[, LIT_RATE_GR_M := LIT_GR_M/POP_M, by = V1]
big_data[, LIT_RATE_GR_F := LIT_GR_F/POP_F, by = V1]

big_data[, MIG_RATE_T := MIG_T/POP_T, by = V1]
big_data[, MIG_RATE_M := MIG_M/POP_M, by = V1]
big_data[, MIG_RATE_F := MIG_F/POP_F, by = V1]
big_data[, MIG_LIT_RATE_T := (MIG_T - ILL_MIG_T)/MIG_T, by = V1]
big_data[, MIG_LIT_RATE_M := (MIG_M - ILL_MIG_M)/MIG_M, by = V1]
big_data[, MIG_LIT_RATE_F := (MIG_F - ILL_MIG_F)/MIG_F, by = V1]
big_data[, MIG_BS_RATE_T := LIT_MIG_BS_T/MIG_T, by = V1]
big_data[, MIG_BS_RATE_M := LIT_MIG_BS_M/MIG_M, by = V1]
big_data[, MIG_BS_RATE_F := LIT_MIG_BS_F/MIG_F, by = V1]
big_data[, MIG_MA_RATE_T := LIT_MIG_SBG_T/MIG_T, by = V1]
big_data[, MIG_MA_RATE_M := LIT_MIG_SBG_M/MIG_M, by = V1]
big_data[, MIG_MA_RATE_F := LIT_MIG_SBG_F/MIG_F, by = V1]
big_data[, MIG_TD_RATE_T := LIT_MIG_TDIP_T/MIG_T, by = V1]
big_data[, MIG_TD_RATE_M := LIT_MIG_TDIP_M/MIG_M, by = V1]
big_data[, MIG_TD_RATE_F := LIT_MIG_TDIP_F/MIG_F, by = V1]
big_data[, MIG_GR_RATE_T := LIT_MIG_GR_T/MIG_T, by = V1]
big_data[, MIG_GR_RATE_M := LIT_MIG_GR_M/MIG_M, by = V1]
big_data[, MIG_GR_RATE_F := LIT_MIG_GR_F/MIG_F, by = V1]
big_data[,1] <- NULL

write.csv(big_data, file = "big_data_rates.csv")

# converting rates to change over time 
big_data_rates <- fread("big_data_rates.csv", header = T)

data_1991 <- big_data_rates %>% filter(YEAR == 1991)
data_2001 <- big_data_rates %>% filter(YEAR == 2001)

big_data_change <- as.data.frame(as.matrix(data_2001[, 5:94,]) - as.matrix(data_1991[, 5:94,]))

write.csv(big_data_change, file = "big_data_change.csv")
