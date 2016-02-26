library(ggplot2)
library(dplyr)

rm(list=ls())
surveys.dat <- read_csv("http://files.figshare.com/1919744/surveys.csv")
surveys.dat
summary(surveys.dat)


surveys.complete <- surveys.dat %>%
  filter(species_id != "") %>%       # species_id 결측값 제거
  filter(!is.na(weight)) %>%          # weight 결측값 제거
  filter(!is.na(hindfoot_length))     # hindfoot_length 결측값 제거
summary(surveys.complete)

# count records per species
species.counts <- surveys.complete %>%
  group_by(species_id) %>%
  tally(sort=TRUE)

tail(species.counts)
head(species.counts)

frequent.species <- species.counts %>%
  filter(n >= 10) %>%
  select(species_id)

surveys.complete <- surveys.complete %>%
  filter(species_id %in% frequent.species$species_id)
frequent.species

surveys.complete
surveys.dat

plot(x = surveys.complete$weight, y = surveys.complete$hindfoot_length)
par("mar")
par(mar=c(1,1,1,1))

ggplot(data = surveys.complete, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha=0.1, color="blue")

ggplot(data = surveys.complete, aes(x = species_id,  y = weight)) +
  geom_boxplot()


ggplot(data = surveys.complete, aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(alpha = 0)

yearly.counts <- surveys.complete %>%
  group_by(year, species_id) %>%
  tally

ggplot(data = yearly.counts, aes(x = year, y = n)) +
  geom_line()

ggplot(data = yearly.counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()


ggplot(data = yearly.counts, aes(x = year, y = n, color = species_id)) +
  geom_line() + facet_wrap(~species_id)


sex_values = c("F", "M")
surveys.complete <- surveys.complete %>%
  filter(sex %in% sex_values)

yearly.sex.counts <- surveys.complete %>%
  group_by(year, species_id, sex) %>%
  tally

ggplot(data = yearly.sex.counts, aes(x = year, y = n, color = species_id, group = sex)) +
  geom_line() + facet_wrap(~ species_id)





