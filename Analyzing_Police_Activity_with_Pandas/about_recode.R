participant <- c(1, 2)
Q1 <- c('agree', 'neutral')
Q2 <- c('neutral', 'agree')
Q3 <- c(NA, NA)
Q4 <- c('Disagree', NA)
Q5 <- c('Agree', NA)

data.frame(participant = participant, 
           Q1 = Q1, 
           Q2 = Q2,
           Q3 = Q3,
           Q4 = Q4, 
           Q5 = Q5) -> df.test

df.test %>%
  mutate(Q1 = recode(Q1, "agree" = 3, "neutral" = 2),
         Q2 = recode(Q2, "neutral" = 2, "agree" = 1),
         Q4 = recode(Q4, "Disagree" = 1),
         Q5 = recode(Q5, "Agree" = 3)
  ) -> df.result


df.test
df.result
