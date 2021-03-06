suppressMessages(library(here)) # BEST WAY TO SPECIFY FILE PATHS
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(library(ggpmisc)) # EXTENSIONS TO ggplot2: ADD EQUATIONS AND FIT STATISTICS TO FITTED LINE PLOTS
library(ggrepel) # MORE ggplot2 EXTENSIONS

# Scale vectors with item names

SOC_items_Teen_1221_Self <- c("q0014", "q0015", "q0016", "q0017", "q0019", "q0020", "q0021", "q0022", "q0024", "q0025")

SOC_rev_items_Teen_1221_Self <- c("q0014", "q0015", "q0016", "q0017", "q0021")

PLA_items_Teen_1221_Self <- c("q0106", "q0107", "q0108", "q0109", "q0110", "q0112", "q0114", "q0115", "q0116", "q0117")

# Read data, recode item vars, calculate SOC, PLA raw scores.
Teen_1221_Self <-
  suppressMessages(as_tibble(read_csv(
    here('INPUT-FILES/TEEN/SPM-2 Teen ages 1221 Self Report Questionnaire.csv')
  ))) %>% select(
    IDNumber,
    Age,
    AgeGroup,
    Gender,
    Ethnicity,
    Region,
    SOC_items_Teen_1221_Self,
    PLA_items_Teen_1221_Self
  ) %>%
  # drop out of age range for form
  drop_na(AgeGroup) %>% 
  # recode items from char to num (mutate_at applies funs to specific columns)
  mutate_at(
    vars(SOC_items_Teen_1221_Self,
         PLA_items_Teen_1221_Self),
    ~ case_when(
      .x == "Never" ~ 1,
      .x == "Occasionally" ~ 2,
      .x == "Frequently" ~ 3,
      .x == "Always" ~ 4,
      TRUE ~ NA_real_
    )
  ) %>%
  # recode reverse-scored items
  mutate_at(
    SOC_rev_items_Teen_1221_Self,
    ~ case_when(.x == 4 ~ 1,
                .x == 3 ~ 2,
                .x == 2 ~ 3,
                .x == 1 ~ 4,
                TRUE ~ NA_real_)
  ) %>%
  # Convert scored item vars to integers
  mutate_at(vars(SOC_items_Teen_1221_Self,
                 PLA_items_Teen_1221_Self),
            ~ as.integer(.x)) %>% 
  # Compute TOT raw score. Note use of `rowSums(.[TOT_items_Teen_1221_Self])`: when used 
  # within a pipe, you can pass a vector of column names to `base::rowSums`, but you
  # must use wrap the column vector in a column-subsetting expression: `.[]`, where the
  # dot is a token for the data in the pipe.
  mutate(SOC_raw = rowSums(.[SOC_items_Teen_1221_Self]),
         PLA_raw = rowSums(.[PLA_items_Teen_1221_Self])
         )

# Create frequency tables for SOC_raw, PLA_raw by AgeGroup
Teen_1221_Self_SOC_freq_AgeGroup <- Teen_1221_Self %>% group_by(AgeGroup) %>% count(SOC_raw) %>% 
  mutate(perc = round(100*(n/sum(n)), 4), cum_per = round(100*(cumsum(n)/sum(n)), 4), lag_tot = lag(SOC_raw), lag_cum_per = lag(cum_per))
Teen_1221_Self_PLA_freq_AgeGroup <- Teen_1221_Self %>% group_by(AgeGroup) %>% count(PLA_raw) %>% 
  mutate(perc = round(100*(n/sum(n)), 4), cum_per = round(100*(cumsum(n)/sum(n)), 4), lag_tot = lag(PLA_raw), lag_cum_per = lag(cum_per))

# Plot histograms for SOC_raw, PLA_raw frequencies by AgeGroup
Self_hist_SOC_age <- ggplot(data = Teen_1221_Self, aes(SOC_raw)) +
  geom_histogram(
    binwidth = .2,
    col = "red",
    fill = "blue",
    alpha = .2
  ) +
  labs(title = "Frequency Distribution") + 
  theme(panel.grid.minor=element_blank()) +
  facet_wrap(~AgeGroup)
print(Self_hist_SOC_age)
ggsave(here('OUTPUT-FILES/TEEN/PLOTS/Self_hist_SOC_age.png'), Self_hist_SOC_age)
Self_hist_PLA_age <- ggplot(data = Teen_1221_Self, aes(PLA_raw)) +
  geom_histogram(
    binwidth = .2,
    col = "red",
    fill = "blue",
    alpha = .2
  ) +
  labs(title = "Frequency Distribution") + 
  theme(panel.grid.minor=element_blank()) +
  facet_wrap(~AgeGroup)
print(Self_hist_PLA_age)
ggsave(here('OUTPUT-FILES/TEEN/PLOTS/Self_hist_PLA_age.png'), Self_hist_PLA_age)

# Compute descriptive statistics, effect sizes for SOC_raw, PLA_raw by AgeGroup
Teen_1221_Self_SOC_desc_AgeGroup <-
  Teen_1221_Self %>% group_by(AgeGroup) %>% arrange(AgeGroup) %>% summarise(n = n(),
                                                                            median = round(median(SOC_raw), 2),
                                                                            mean = round(mean(SOC_raw), 2),
                                                                            sd = round(sd(SOC_raw), 2)) %>%
  mutate(ES = round((mean - lag(mean))/((sd + lag(sd))/2),2), group = c(1:4))
write_csv(Teen_1221_Self_SOC_desc_AgeGroup, here('OUTPUT-FILES/TEEN/DESCRIPTIVES/Self_SOC_desc_AgeGroup.csv'))
Teen_1221_Self_PLA_desc_AgeGroup <-
  Teen_1221_Self %>% group_by(AgeGroup) %>% arrange(AgeGroup) %>% summarise(n = n(),
                                                                            median = round(median(PLA_raw), 2),
                                                                            mean = round(mean(PLA_raw), 2),
                                                                            sd = round(sd(PLA_raw), 2)) %>%
  mutate(ES = round((mean - lag(mean))/((sd + lag(sd))/2),2), group = c(1:4))
write_csv(Teen_1221_Self_PLA_desc_AgeGroup, here('OUTPUT-FILES/TEEN/DESCRIPTIVES/Self_PLA_desc_AgeGroup.csv'))

AgeGroup <- Teen_1221_Self_PLA_desc_AgeGroup %>% pull(AgeGroup)

# Plot TOT_raw means, SDs by AgeGroup
Self_mean_plot_SOC <- ggplot(data = Teen_1221_Self_SOC_desc_AgeGroup, aes(group, mean)) +
  geom_point(
    col = "blue",
    fill = "blue",
    alpha = .5,
    size = 3,
    shape = 23
  ) +
  geom_label_repel(aes(label = mean), hjust = .7, vjust = -1, label.padding = unit(0.1, "lines"), size = 4, col = "blue") +
  scale_x_continuous(breaks = seq(1, 4, 1), labels = AgeGroup) +
  scale_y_continuous(breaks = seq(0, 30, 5), limits = c(0, 30)) +
  labs(title = "Raw Score Means (with SDs)", x = "AgeGroup", y = "SOC") +
  geom_errorbar(
    aes(ymin = mean - sd, ymax = mean + sd),
    col = "red",
    size = 0.2,
    width = 0.2
  ) 
print(Self_mean_plot_SOC)
ggsave(here('OUTPUT-FILES/TEEN/PLOTS/Self_mean_plot_SOC.png'), Self_mean_plot_SOC)
Self_mean_plot_PLA <- ggplot(data = Teen_1221_Self_PLA_desc_AgeGroup, aes(group, mean)) +
  geom_point(
    col = "blue",
    fill = "blue",
    alpha = .5,
    size = 3,
    shape = 23
  ) +
  geom_label_repel(aes(label = mean), hjust = .7, vjust = -1, label.padding = unit(0.1, "lines"), size = 4, col = "blue") +
  scale_x_continuous(breaks = seq(1, 4, 1), labels = AgeGroup) +
  scale_y_continuous(breaks = seq(0, 30, 5), limits = c(0, 30)) +
  labs(title = "Raw Score Means (with SDs)", x = "AgeGroup", y = "PLA") +
  geom_errorbar(
    aes(ymin = mean - sd, ymax = mean + sd),
    col = "red",
    size = 0.2,
    width = 0.2
  ) 
print(Self_mean_plot_PLA)
ggsave(here('OUTPUT-FILES/TEEN/PLOTS/Self_mean_plot_PLA.png'), Self_mean_plot_PLA)

# Check for duplicate IDnumber, missing on AgeGroup.

# Teen_1221_Self_dup_IDnumber <- Teen_1221_Self %>% count(IDNumber) %>% filter(n > 1)
# write_csv(Teen_1221_Self_dup_IDnumber, here("DATA/DATA_CLEANUP_FILES/Teen_1221_Self_dup_IDnumber.csv"))
# 
# Teen_1221_Self_missing_AgeGroup <- Teen_1221_Self %>% filter(is.na(AgeGroup)) %>% select(IDNumber)
# write_csv(Teen_1221_Self_missing_AgeGroup, here("DATA/DATA_CLEANUP_FILES/Teen_1221_Self_missing_AgeGroup.csv"))

