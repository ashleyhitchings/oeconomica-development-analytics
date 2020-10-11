install.packages("data.table")
install.packages("tidyverse")
install.packages("ggthemes")
library(data.table)
library(ggplot2)
library(dplyr)
library(ggthemes)
setwd("~/Dropbox/Oeconomica Education Migration Group")

merged_data <- fread("merged_1991&2001_2.csv", header = T)
merged_data[, LIT_RATE_T := LIT_T/POP_T,]
merged_data[, LIT_RATE_F := LIT_F/POP_F,]
merged_data[, LIT_RATE_M := LIT_M/POP_M,]


# Distribution of Literacy Rates by State and Year
merged_data %>% filter(AGE_GROUP != "Age not stated" & AGE_GROUP !="All ages") %>% 
  ggplot(aes(x = STATE, y = LIT_RATE_T, color = factor(YEAR))) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("State") + 
  ylab("Literacy Rate") + 
  ggtitle("Literacy Rates by Indian State") +
  labs(color = 'Year')

# Literacy rates by age group (1991 and 2001)
merged_data %>% 
  filter(AGE_GROUP != "Age not stated" & AGE_GROUP !="All ages") %>% 
  ggplot(aes(AGE_GROUP, LIT_RATE_T, color = AGE_GROUP)) + 
  geom_boxplot(show.legend = FALSE) +
  xlab("Age Group") + 
  ylab("Literacy Rate") + 
  ggtitle("Literacy Rates by Age Group") + 
  facet_grid(.~YEAR) 

# Literate pop w/ primary edu by age group
merged_data %>% 
  filter(AGE_GROUP != "Age not stated" & AGE_GROUP !="All ages") %>% 
  ggplot(aes(AGE_GROUP, LIT_PR_T, color = factor(YEAR))) + 
  geom_boxplot() +
  xlab("Age Group") + 
  ylab("Literacy Rate") + 
  ggtitle("Literate Population with Primary Education by Age Group") +
  labs(color = "Year")

# Literate population by gender and age group
install.packages("gridExtra")
library(gridExtra)

male_lit <- merged_data %>% 
  filter(AGE_GROUP != "Age not stated" & AGE_GROUP !="All ages") %>% 
  ggplot(aes(AGE_GROUP, LIT_M, color = factor(YEAR))) + 
  geom_boxplot() +
  xlab("Age Group") + 
  ylab("Literacy Rate") + 
  ggtitle("Male Literate Population") +
  labs(color = "Year") 
  
female_lit <- merged_data %>% 
  filter(AGE_GROUP != "Age not stated" & AGE_GROUP !="All ages") %>% 
  ggplot(aes(AGE_GROUP, LIT_F, color = factor(YEAR))) + 
  geom_boxplot() +
  xlab("Age Group") + 
  ylab("Literacy Rate") + 
  ggtitle("Female Literate Population") +
  labs(color = "Year") 

grid.arrange(male_lit, female_lit, ncol = 2)

# Summary stats by literacy rate and tot literate pop
install.packages("table1")
library(table1)
table1::label(merged_data$LIT_RATE_T) <- "Total Literacy Rate"
table1::label(merged_data$LIT_RATE_F) <- "Female Literacy Rate"
table1::label(merged_data$LIT_RATE_M) <- "Male Literacy Rate"
table1::label(merged_data$LIT_T) <- "Total Literate Population"
table1::label(merged_data$LIT_F) <- "Female Literate Population"
table1::label(merged_data$LIT_M) <- "Male Literate Population"
table1::table1(~LIT_RATE_T + LIT_RATE_F + LIT_RATE_M + LIT_T + LIT_F + LIT_M | YEAR, data = merged_data)

# Summary stats by age group
group1 <- merged_data %>% filter(AGE_GROUP == 1)
group2 <- merged_data %>% filter(AGE_GROUP == 2)
group3 <- merged_data %>% filter(AGE_GROUP == 3)
group4 <- merged_data %>% filter(AGE_GROUP == 4)
group5 <- merged_data %>% filter(AGE_GROUP == 5)
group6 <- merged_data %>% filter(AGE_GROUP == 6)
group7 <- merged_data %>% filter(AGE_GROUP == 7)
group8 <- merged_data %>% filter(AGE_GROUP == 8)
group9 <- merged_data %>% filter(AGE_GROUP == 9)
table1::label(group1$LIT_RATE_T) <- "Total Literacy Rate for 0-10 Years"
table1::label(group2$LIT_RATE_T) <- "Total Literacy Rate for 11-20 Years"
table1::table1(~group1$LIT_RATE_T + group2$LIT_RATE_T | YEAR, data = merged_data)

data_1991 <- merged_data %>% filter(YEAR == 1991)
data_2001 <- merged_data %>% filter(YEAR == 2001)
View(data_1991)

table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 1]) <- "Literacy Rate for 0-9 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 2]) <- "Literacy Rate for 10-19 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 3]) <- "Literacy Rate for 20-29 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 4]) <- "Literacy Rate for 30-39 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 5]) <- "Literacy Rate for 40-49 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 6]) <- "Literacy Rate for 50-59 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 7]) <- "Literacy Rate for 60-69 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 8]) <- "Literacy Rate for 70-79 Years"
table1::label(data_1991$LIT_RATE_T[AGE_GROUP == 9]) <- "Literacy Rate for 80+ Years"
table1::table1(~data_1991$LIT_RATE_T[AGE_GROUP == 1] + 
                 data_1991$LIT_RATE_T[AGE_GROUP == 2] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 3] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 4] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 5] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 6] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 7] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 8] +
                 data_1991$LIT_RATE_T[AGE_GROUP == 9]
               | YEAR, data = data_1991)

table1::table1(~data_2001$LIT_RATE_T[AGE_GROUP == 1] + 
                 data_2001$LIT_RATE_T[AGE_GROUP == 2] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 3] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 4] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 5] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 6] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 7] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 8] +
                 data_2001$LIT_RATE_T[AGE_GROUP == 9]
               | YEAR, data = data_2001)
