suppressMessages(library(here))
suppressMessages(suppressWarnings(library(tidyverse)))
library(ggrepel) # ggplot2 EXTENSIONS

# Desampling is applied first to the Home form sample, the excluded cases are
# then also removed from the other form samples

Teen_1221_Home_Eng <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/SM-QUAL-COMBO-NORMS-INPUT/Teen-1221-Home-combo-norms-input.csv")
  ))) 
Teen_1221_Home_Sp <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/SP-NORMS-INPUT/Teen-1221-Home-Sp-norms-input.csv")
  ))) 
Teen_1221_Home_inHouse <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/INHOUSE-NORMS-INPUT/Teen-1221-Home-inHouse-norms-input.csv")
  ))) 
Teen_1221_Home <- bind_rows(Teen_1221_Home_Eng, Teen_1221_Home_Sp, Teen_1221_Home_inHouse) %>% 
  arrange(IDNumber)


# Subsample: 100 Blacks with HS deg or some college
set.seed(123)
Teen_1221_Home_Black_HSsomeColl <- Teen_1221_Home %>% 
  filter(Ethnicity == "Black" & 
           (ParentHighestEducation == "High school graduate (including GED)" | 
              ParentHighestEducation == "Some college or associate degree" )) %>% 
  sample_n(100)

# Remove all Blacks with HS deg or some college from main sample
Teen_1221_Home_not_Black_HSsomeColl <- Teen_1221_Home %>% 
  filter(!(Ethnicity == "Black" & 
           (ParentHighestEducation == "High school graduate (including GED)" | 
              ParentHighestEducation == "Some college or associate degree" )))
  
# combine subsamples to create desampled data set

Teen_1221_Home_desamp <- bind_rows(Teen_1221_Home_Black_HSsomeColl, Teen_1221_Home_not_Black_HSsomeColl) %>% 
  arrange(IDNumber)


write_csv(Teen_1221_Home_desamp, here('INPUT-FILES/TEEN/ALLDATA-DESAMP-NORMS-INPUT/Teen-1221-Home-allData-desamp.csv'))

# extract ID numbers of cases excluded in Home desamp process

Teen_1221_Home_desamp_excludedID <- Teen_1221_Home %>% anti_join(
  Teen_1221_Home_desamp, 
  by = 'IDNumber'
  ) %>% 
  select(IDNumber) %>% 
  arrange(IDNumber)

# Apply Home desampling to School data set

Teen_1221_School_Eng <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/SM-ONLY-NORMS-INPUT/Teen-1221-School-SM-only-norms-input.csv")
  ))) 
Teen_1221_School_inHouse <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/INHOUSE-NORMS-INPUT/Teen-1221-School-inHouse-norms-input.csv")
  ))) 
Teen_1221_School <- bind_rows(Teen_1221_School_Eng, Teen_1221_School_inHouse) %>% 
  arrange(IDNumber)

Teen_1221_School_desamp <- Teen_1221_School %>% anti_join(
  Teen_1221_Home_desamp_excludedID, 
  by = 'IDNumber'
) %>% 
  arrange(IDNumber)

write_csv(Teen_1221_School_desamp, here('INPUT-FILES/TEEN/ALLDATA-DESAMP-NORMS-INPUT/Teen-1221-School-allData-desamp.csv'))

# Apply Home desampling to Self data set

Teen_1221_Self_Eng <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/SM-QUAL-COMBO-NORMS-INPUT/Teen-1221-Self-combo-norms-input.csv")
  ))) 
Teen_1221_Self_Sp <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/SP-NORMS-INPUT/Teen-1221-Self-Sp-norms-input.csv")
  ))) 
Teen_1221_Self_inHouse <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/TEEN/INHOUSE-NORMS-INPUT/Teen-1221-Self-inHouse-norms-input.csv")
  ))) 
Teen_1221_Self <- bind_rows(Teen_1221_Self_Eng, Teen_1221_Self_Sp, Teen_1221_Self_inHouse) %>% 
  arrange(IDNumber)

Teen_1221_Self_desamp <- Teen_1221_Self %>% anti_join(
  Teen_1221_Home_desamp_excludedID, 
  by = 'IDNumber'
) %>% 
  arrange(IDNumber)

write_csv(Teen_1221_Self_desamp, here('INPUT-FILES/TEEN/ALLDATA-DESAMP-NORMS-INPUT/Teen-1221-Self-allData-desamp.csv'))

# EXAMINE DATA---------------------------------

# Create frequency tables for TOT_raw by data source
Teen_1221_Home_desamp_TOT_freq <- Teen_1221_Home_desamp %>% group_by(data, age_range) %>% count(TOT_raw) %>%
  mutate(
    perc = round(100*(n/sum(n)), 4), 
    cum_per = round(100*(cumsum(n)/sum(n)), 4)
  )

# write_csv(Teen_1221_Home_desamp_TOT_freq, here('OUTPUT-FILES/TEEN/FREQUENCIES/Teen-1221-Home-Eng-Sp-TOT-freq-data.csv'))


# Compute descriptive statistics, effect sizes for TOT_raw by age range
Teen_1221_Home_desamp_TOT_desc_age <-
  Teen_1221_Home_desamp %>% group_by(age_range) %>% arrange(age_range) %>% summarise(n = n(),
                                                                        median = round(median(TOT_raw), 2),
                                                                        mean = round(mean(TOT_raw), 2),
                                                                        sd = round(sd(TOT_raw), 2)) %>%
  mutate(ES = round((mean - lag(mean))/((sd + lag(sd))/2),2)#,
         # group = c(1:2)
  )

write_csv(Teen_1221_Home_desamp_TOT_desc_age, here('OUTPUT-FILES/TEEN/DESCRIPTIVES/Teen-1221-Home-desamp-TOT-desc-age.csv'))

# # Generate single table comparing descriptives from Eng and Sp sources.
# Teen_1221_Home_desamp_TOT_desc_Eng <- Teen_1221_Home_desamp_TOT_desc %>% 
#   filter(data == 'Eng') %>% 
#   setNames(., str_c(names(.), 'Eng', sep = '_')) %>% 
#   ungroup() %>% 
#   select(-matches('data|median|group'))
# Teen_1221_Home_desamp_TOT_desc_Sp <- Teen_1221_Home_desamp_TOT_desc %>% 
#   filter(data == 'Sp') %>% 
#   setNames(., str_c(names(.), 'Sp', sep = '_')) %>% 
#   ungroup() %>% 
#   select(-matches('data|median|group'))
# 
# Teen_1221_Home_desamp_TOT_desc_desamp <- Teen_1221_Home_desamp_TOT_desc_Eng %>% 
#   bind_cols(Teen_1221_Home_desamp_TOT_desc_Sp) %>% 
#   # select(-age_range_Sp) %>% 
#   # rename(age_range = age_range_Eng) %>% 
#   mutate(
#     diff = round(mean_Eng - mean_Sp, 2),
#     ES_diff = round((mean_Eng - mean_Sp) / ((sd_Eng + sd_Sp) / 2), 2)
#   )
# 
# write_csv(Teen_1221_Home_desamp_TOT_desc_desamp, here('OUTPUT-FILES/TEEN/DESCRIPTIVES/Teen-1221-Home-desamp-TOT-desc.csv'))

# Plot TOT_raw means, SDs by AgeGroup
mean_plot <- ggplot(data = Teen_1221_Home_desamp_TOT_desc, aes(group, mean)) +
  geom_point(
    col = "blue",
    fill = "blue",
    alpha = .5,
    size = 3,
    shape = 23
  ) +
  geom_label_repel(aes(label = mean), hjust = .7, vjust = -1, label.padding = unit(0.1, "lines"), size = 4, col = "blue") +
  scale_x_continuous(breaks = seq(1, 2, 1), labels = unique(Teen_1221_Home_desamp_TOT_desc$data)) +
  scale_y_continuous(breaks = seq(0, 250, 25), limits = c(0, 250)) +
  labs(title = "Raw Score Means (with SDs)", x = "Data Sourcce", y = "TOT") +
  geom_errorbar(
    aes(ymin = mean - sd, ymax = mean + sd),
    col = "red",
    size = 0.2,
    width = 0.2
  )
print(mean_plot)


