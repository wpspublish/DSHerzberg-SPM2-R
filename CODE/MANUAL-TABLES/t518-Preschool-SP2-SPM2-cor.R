###### LOAD PACKAGES -----------------------------------------------------------
suppressPackageStartupMessages(library(here))
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(library(data.table))
suppressMessages(library(psych))
### Preschool-25-Home-Stand DATA ---------------------------------------------------------
# READ SP2 FORMS---------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-Home-item-vectors.R"))

Preschool_25_Home_Stand_SP2_raw <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/SP2_Preschool_Standard.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) 

# Evaluate whether de-sampled stand data can be used, or whether you need to
# recover cases from original non-desampled input files. Designate chosen sample
# as `orig_data`

# find shared cases with Preschool-25-Home-Stand original input files
orig_data <-
  suppressMessages(as_tibble(read_csv(
    here('INPUT-FILES/PRESCHOOL/SM-QUAL-COMBO-NORMS-INPUT/Preschool-25-Home-combo-norms-input.csv')
  )))

# find shared cases with desampled data that has T-scores already
# source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-Home-Stand.R"))
# 
# orig_data <- Preschool_25_Home_Stand

# READ SPM-2 FORMS ---------------------------------------
# join with SP2 data, obtain SPM2 raw scores

Preschool_25_Home_Stand_SP2_SPM2_raw <- Preschool_25_Home_Stand_SP2_raw %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("RS"), SOC_raw, VIS_raw, HEA_raw, TOU_raw, 
         TS_raw, BOD_raw, BAL_raw, PLA_raw, TOT_raw) %>% 
  rename_at(vars(contains("raw")), ~ str_c("c.", .))%>% 
  rename_at(vars(contains("RS")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("RS")), ~ str_replace(., "RS", "raw"))


# GENERATE SP2-SPM CORR TABLE -------------------------------------
cor_cols <- Preschool_25_Home_Stand_SP2_SPM2_raw %>% 
  select(contains('_raw'))

Preschool_25_Home_Stand_SP2_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace_all(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-Home-Stand',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(SP2_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))


### Preschool-25-Home-Clin DATA ---------------------------------------------------------
# READ SP2 FORMS---------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-Home-item-vectors.R"))

Preschool_25_Home_Clin_SP2_raw <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/SP2_Preschool_Clinical.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) 

# Evaluate whether de-sampled clin data can be used, or whether you need to
# recover cases from original non-desampled input files. Designate chosen sample
# as `orig_data`

# find shared cases with Preschool-25-Home-Clin original input files
# orig_data <-
#   suppressMessages(as_tibble(read_csv(
#     here('INPUT-FILES/PRESCHOOL/SM-QUAL-COMBO-NORMS-INPUT/Preschool-25-Home-combo-norms-input.csv')
#   )))

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-Home-Clin.R"))

orig_data <- Preschool_25_Home_Clin

# READ SPM-2 FORMS ---------------------------------------
# join with SP2 data, obtain SPM2 raw scores

Preschool_25_Home_Clin_SP2_SPM2_raw <- Preschool_25_Home_Clin_SP2_raw %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("RS"), SOC_raw, VIS_raw, HEA_raw, TOU_raw, 
         TS_raw, BOD_raw, BAL_raw, PLA_raw, TOT_raw) %>% 
  rename_at(vars(contains("raw")), ~ str_c("c.", .))%>% 
  rename_at(vars(contains("RS")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("RS")), ~ str_replace(., "RS", "raw"))


# GENERATE SP2-SPM CORR TABLE -------------------------------------
cor_cols <- Preschool_25_Home_Clin_SP2_SPM2_raw %>% 
  select(contains('_raw'))

Preschool_25_Home_Clin_SP2_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace_all(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-Home-Clin',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(SP2_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))


### Preschool-25-School-Stand DATA ---------------------------------------------------------
# READ SP2 FORMS---------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-School-item-vectors.R"))

Preschool_25_School_Stand_SP2_raw <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/SP2_Preschool_School_Standard.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) #%>% 
# remove outliers
# mutate(TOT = rowSums(.[2:ncol(.)])) %>% 
# filter(TOT > 40)

# Evaluate whether de-sampled stand data can be used, or whether you need to
# recover cases from original non-desampled input files. Designate chosen sample
# as `orig_data`

# find shared cases with Preschool-25-School-Stand original input files
orig_data <-
  suppressMessages(as_tibble(read_csv(
    here('INPUT-FILES/PRESCHOOL/SM-ONLY-NORMS-INPUT/Preschool-25-School-SM-only-norms-input.csv')
  )))

# find shared cases with desampled data that has T-scores already
# source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-School-Stand.R"))
# 
# orig_data <- Preschool_25_School_Stand

# READ SPM-2 FORMS ---------------------------------------
# join with SP2 data, obtain SPM2 raw scores

Preschool_25_School_Stand_SP2_SPM2_raw <- Preschool_25_School_Stand_SP2_raw %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("RS"), SOC_raw, VIS_raw, HEA_raw, TOU_raw, 
         TS_raw, BOD_raw, BAL_raw, PLA_raw, TOT_raw) %>% 
  rename_at(vars(contains("raw")), ~ str_c("c.", .))%>% 
  rename_at(vars(contains("RS")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("RS")), ~ str_replace(., "RS", "raw"))


# GENERATE SP2-SPM CORR TABLE -------------------------------------
cor_cols <- Preschool_25_School_Stand_SP2_SPM2_raw %>% 
  select(contains('_raw'))

Preschool_25_School_Stand_SP2_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace_all(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-School-Stand',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(SP2_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))


### Preschool-25-School-Clin DATA ---------------------------------------------------------
# READ SP2 FORMS---------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-School-item-vectors.R"))

Preschool_25_School_Clin_SP2_raw <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/SP2_Preschool_School_Clinical.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) #%>% 
# remove outliers
# mutate(TOT = rowSums(.[2:ncol(.)])) %>% 
# filter(TOT > 40)

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-School-Clin.R"))

orig_data <- Preschool_25_School_Clin

# READ SPM-2 FORMS ---------------------------------------
# join with SP2 data, obtain SPM2 raw scores

Preschool_25_School_Clin_SP2_SPM2_raw <- Preschool_25_School_Clin_SP2_raw %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("RS"), SOC_raw, VIS_raw, HEA_raw, TOU_raw, 
         TS_raw, BOD_raw, BAL_raw, PLA_raw, TOT_raw) %>% 
  rename_at(vars(contains("raw")), ~ str_c("c.", .))%>% 
  rename_at(vars(contains("RS")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("RS")), ~ str_replace(., "RS", "raw"))


# GENERATE SP2-SPM CORR TABLE -------------------------------------
cor_cols <- Preschool_25_School_Clin_SP2_SPM2_raw %>% 
  select(contains('_raw'))

Preschool_25_School_Clin_SP2_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace_all(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-School-Clin',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(SP2_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))


###### WRITE MANUAL TABLE OUTPUT -----------------------------------------------
SP2_SPM2_cor_table <- bind_rows(
  Preschool_25_Home_Stand_SP2_SPM2_cor_table,
  Preschool_25_Home_Clin_SP2_SPM2_cor_table,
  Preschool_25_School_Stand_SP2_SPM2_cor_table,
  Preschool_25_School_Clin_SP2_SPM2_cor_table
)

write_csv(SP2_SPM2_cor_table,
          here(
            paste0(
              'OUTPUT-FILES/MANUAL-TABLES/t518-Preschool-SP2-SPM2-cor-',
              format(Sys.Date(), "%Y-%m-%d"),
              '.csv'
            )
          ),
          na = '')


