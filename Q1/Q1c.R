# Clear the environment:
rm(list = ls()) 

library(plyr)

cards = 500
N = 100

trial_n = 1e6

# Assume each unique Chocolate Frog Card has a unique label from 1 to N
# Set Agrippa as num 1 and Ptolemy as num 2:
Agrippa = 1
Ptolemy = 2
set.seed(0)

result <- replicate(trial_n, {
  #Ron Weasley collects 500 cards and finds Agrippa or Ptolemy:
  a = sample.int(N, cards, replace = TRUE)
  (!(Agrippa %in% a)) & (!(Ptolemy %in% a))
})

result = data.frame(result)

count_num = count(result == TRUE)[2, 2]

# Do the calculation:
p = count_num / trial_n

# The probability that one has 500 cards (with possible replications) 
# while neither Agrippa nor Ptolemy is included:
print(paste0("The probability is approximately ", p))


