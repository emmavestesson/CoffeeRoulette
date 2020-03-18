library(tidyverse)
df <- read_csv(here::here('names.csv'))
team1 <- df %>% 
  filter(team=='IAU')

team1 <- team1[sample(1:nrow(team1)),]



team2 <- df %>% 
  filter(team=='In-house')

you <- 'Emma'
first_person <- sample_n(team2,1) %>% 
  pull(name)

happy_meeting_group <- combine(you, first_person)

glue('Dear ', first_person, praise(',\n ${EXCLAMATION}! You are my ${adjective} coffee buddy')) 

