###### LOAD PACKAGES -----------------------------------------------------------
suppressPackageStartupMessages(library(here))
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(library(psych))
### Preschool-25-Home-School-Stand DATA ---------------------------------------------------------
## READ ABAS3 FORMS, JOIN WITH SPM-2 T-SCORES ----------------------------------
# 25 HOME DATA -----------------------------------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-Home-item-vectors.R"))

Preschool_25_Home_Stand_ABAS3_T <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/ABAS_3_Preschool_PPC_Standard.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("_StanS")), ~ str_replace(., "_StanS", "_ss")) %>% 
  rename(HomeSchool_ss = Home_ss)

# orig_data <-
#   suppressMessages(as_tibble(read_csv(
#     here('INPUT-FILES/PRESCHOOL/SM-QUAL-COMBO-NORMS-INPUT/Preschool-25-Home-combo-norms-input.csv')
#   )))

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-Home-Stand.R"))

orig_data <- Preschool_25_Home_Stand

# obtain SPM2 T scores and join with ABAS3 data
Preschool_25_Home_Stand_ABAS3_SPM2_T <- Preschool_25_Home_Stand_ABAS3_T %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, age_range, contains("ss"), SOC_raw, VIS_raw, HEA_raw, TOU_raw, 
         TS_raw, BOD_raw, BAL_raw, PLA_raw, TOT_raw) %>% 
  rename_at(vars(contains("ss")), ~ str_c("r.", .))

# split sample by age_range

Preschool_24_Home_Stand_ABAS3_SPM2_T <- Preschool_25_Home_Stand_ABAS3_SPM2_T %>% filter(age_range == "2 to 4 years")
Preschool_5_Home_Stand_ABAS3_SPM2_T <- Preschool_25_Home_Stand_ABAS3_SPM2_T %>% filter(age_range == "5 years")

# 24 DATA

# read raw-to-t lookup tables, create lookup cols by scale
Preschool_24_rawToT <-
  suppressMessages(as_tibble(read_csv(
    here("OUTPUT-FILES/PRESCHOOL/RAW-T-LOOKUP-TABLES/Preschool-24-Home-raw-T-lookup.csv")
  )))

map_df(
  scale_order,
  ~
    Preschool_24_rawToT %>%
    select(raw,!!str_c(.x, '_NT')) %>%
    rename(!!str_c(.x, "_raw") := raw) %>%
    assign(str_c(.x, '_24_lookup_col'), ., envir = .GlobalEnv)
)

# look up T scores with left_join, bind T score columns to main data set
output_24 <- map_dfc(score_names,
                     ~
                       Preschool_24_Home_Stand_ABAS3_SPM2_T %>% left_join(eval(as.name(
                         str_c(.x, '_24_lookup_col')
                       )),
                       by = str_c(.x, '_raw')) %>%
                       select(!!str_c(.x, '_NT'))) %>%
  bind_cols(Preschool_24_Home_Stand_ABAS3_SPM2_T, .) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("NT")), ~ str_c("c.", .)) %>%
  select(-age_range, -(contains("_raw")))

rm(list = ls(pattern = "col"))

# 5 DATA

# read raw-to-t lookup tables, create lookup cols by scale
Preschool_5_rawToT <-
  suppressMessages(as_tibble(read_csv(
    here("OUTPUT-FILES/PRESCHOOL/RAW-T-LOOKUP-TABLES/Preschool-5-Home-raw-T-lookup.csv")
  )))

map_df(
  scale_order,
  ~
    Preschool_5_rawToT %>%
    select(raw,!!str_c(.x, '_NT')) %>%
    rename(!!str_c(.x, "_raw") := raw) %>%
    assign(str_c(.x, '_5_lookup_col'), ., envir = .GlobalEnv)
)

# look up T scores with left_join, bind T score columns to main data set
output_5 <- map_dfc(score_names,
                    ~
                      Preschool_5_Home_Stand_ABAS3_SPM2_T %>% left_join(eval(as.name(
                        str_c(.x, '_5_lookup_col')
                      )),
                      by = str_c(.x, '_raw')) %>%
                      select(!!str_c(.x, '_NT'))) %>%
  bind_cols(Preschool_5_Home_Stand_ABAS3_SPM2_T, .) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("NT")), ~ str_c("c.", .)) %>%
  select(-age_range, -(contains("_raw")))

rm(list = ls(pattern = "col"))

# recombine 25 data
scale_order <- c("c.SOC_NT", "c.VIS_NT", "c.HEA_NT", "c.TOU_NT", 
                 "c.TS_NT", "c.BOD_NT", "c.BAL_NT", "c.PLA_NT", "c.TOT_NT")

Preschool_25_Home_Stand_ABAS3_ss_SPM2_T <- bind_rows(
  output_24,
  output_5
) %>% 
  arrange(IDNumber) %>% 
  select(IDNumber:r.Prac_ss, scale_order, -r.CommunityUse_ss)

rm(list = setdiff(ls(), ls(pattern = "ss")))

# 25 SCHOOL DATA -----------------------------------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-School-item-vectors.R"))

Preschool_25_School_Stand_ABAS3_T <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/ABAS_3_Preschool_TDP_Standard.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("_StanS")), ~ str_replace(., "_StanS", "_ss")) %>% 
  rename(HomeSchool_ss = School_ss)


# orig_data <-
#   suppressMessages(as_tibble(read_csv(
#     here('INPUT-FILES/PRESCHOOL/SM-ONLY-NORMS-INPUT/Preschool-25-School-SM-only-norms-input.csv')
#   )))

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-School-Stand.R"))

orig_data <- Preschool_25_School_Stand

# obtain SPM2 T scores and join with ABAS3 data
Preschool_25_School_Stand_ABAS3_ss_SPM2_T <- Preschool_25_School_Stand_ABAS3_T %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("ss"), SOC_NT, VIS_NT, HEA_NT, TOU_NT, 
         TS_NT, BOD_NT, BAL_NT, PLA_NT, TOT_NT) %>% 
  rename_at(vars(contains("ss")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("NT")), ~ str_c("c.", .))

rm(list = setdiff(ls(), ls(pattern = "ss")))

# GENERATE ABAS3-SPM CORR TABLE -------------------------------------
# stack Home and School data
Preschool_25_Stand_ABAS3_ss_SPM2_T <- bind_rows(
  Preschool_25_Home_Stand_ABAS3_ss_SPM2_T,
  Preschool_25_School_Stand_ABAS3_ss_SPM2_T
)

cor_cols <- Preschool_25_Stand_ABAS3_ss_SPM2_T %>% 
  select(-IDNumber)

Preschool_25_Stand_ABAS3_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-Home-School-Stand',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(ABAS3_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))

### Preschool-25-Home-School-Clin DATA ---------------------------------------------------------
## READ ABAS3 FORMS, JOIN WITH SPM-2 T-SCORES ----------------------------------
# 25 HOME DATA -----------------------------------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-Home-item-vectors.R"))

Preschool_25_Home_Clin_ABAS3_T <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/ABAS_3_Preschool_PPC_Clinical.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("_StanS")), ~ str_replace(., "_StanS", "_ss")) %>% 
  rename(HomeSchool_ss = Home_ss)

# orig_data <-
#   suppressMessages(as_tibble(read_csv(
#     here('INPUT-FILES/PRESCHOOL/SM-QUAL-COMBO-NORMS-INPUT/Preschool-25-Home-combo-norms-input.csv')
#   )))

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-Home-Clin.R"))

orig_data <- Preschool_25_Home_Clin

# obtain SPM2 T scores and join with ABAS3 data
scale_order <- c("c.SOC_NT", "c.VIS_NT", "c.HEA_NT", "c.TOU_NT", 
                 "c.TS_NT", "c.BOD_NT", "c.BAL_NT", "c.PLA_NT", "c.TOT_NT")

Preschool_25_Home_Clin_ABAS3_ss_SPM2_T <- Preschool_25_Home_Clin_ABAS3_T %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("ss"), SOC_NT, VIS_NT, HEA_NT, TOU_NT, 
         TS_NT, BOD_NT, BAL_NT, PLA_NT, TOT_NT) %>% 
  rename_at(vars(contains("ss")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("NT")), ~ str_c("c.", .)) %>% 
  arrange(IDNumber) %>% 
  select(IDNumber:r.Prac_ss, scale_order, -r.CommunityUse_ss)

rm(list = setdiff(ls(), ls(pattern = "ss|table")))

# 25 SCHOOL DATA -----------------------------------------------------------------
source(here("CODE/ITEM-VECTORS/Preschool-25-School-item-vectors.R"))

Preschool_25_School_Clin_ABAS3_T <-
  suppressMessages(as_tibble(read_csv(
    here("INPUT-FILES/PRESCHOOL/PAPER-FORMS/ABAS_3_Preschool_TDP_Clinical.csv")
  ))) %>% 
  rename(IDNumber = ID) %>% 
  drop_na(IDNumber) %>% 
  arrange(IDNumber) %>% 
  rename_at(vars(contains("_StanS")), ~ str_replace(., "_StanS", "_ss")) %>% 
  rename(HomeSchool_ss = School_ss)

# find shared cases with desampled data that has T-scores already
source(here("CODE/READ-T-SCORES-PER-CASE/read-Preschool-25-School-Clin.R"))

orig_data <- Preschool_25_School_Clin

# obtain SPM2 T scores and join with ABAS3 data
Preschool_25_School_Clin_ABAS3_ss_SPM2_T <- Preschool_25_School_Clin_ABAS3_T %>% 
  inner_join(orig_data, by = "IDNumber") %>% 
  select(IDNumber, contains("ss"), SOC_NT, VIS_NT, HEA_NT, TOU_NT, 
         TS_NT, BOD_NT, BAL_NT, PLA_NT, TOT_NT) %>% 
  rename_at(vars(contains("ss")), ~ str_c("r.", .)) %>% 
  rename_at(vars(contains("NT")), ~ str_c("c.", .)) 

rm(list = setdiff(ls(), ls(pattern = "ss|table")))

# GENERATE ABAS3-SPM CORR TABLE -------------------------------------
# stack Home and School data
Preschool_25_Clin_ABAS3_ss_SPM2_T <- bind_rows(
  Preschool_25_Home_Clin_ABAS3_ss_SPM2_T,
  Preschool_25_School_Clin_ABAS3_ss_SPM2_T
)

cor_cols <- Preschool_25_Clin_ABAS3_ss_SPM2_T %>% 
  select(-IDNumber)

Preschool_25_Clin_ABAS3_SPM2_cor_table <-
  corr.test(cor_cols)[['ci']] %>%
  rownames_to_column(var = 'pair') %>%
  separate(pair, c("row", "col"), sep = "-") %>%
  filter((str_detect(row, "r.") &
            str_detect(col, "c.")) & !str_detect(col, "r.")) %>%
  mutate_at(vars(row, col), ~ str_replace(str_sub(., 3), "_", "")) %>%
  mutate(
    form = case_when(rownames(.) == "1" ~ 'Preschool-25-Home-School-Clin',
                     T ~ NA_character_),
    n = case_when(rownames(.) == "1" ~ corr.test(cor_cols)[['n']][1],
                  T ~ NA_real_)
  ) %>%
  mutate_if(is.numeric, ~ round(., 3)) %>%
  select(form, n, col, row, r, p) %>% 
  rename(ABAS3_col_label = row, SPM2_row_label = col)

rm(list = setdiff(ls(), ls(pattern = 'table')))

###### WRITE MANUAL TABLE OUTPUT -----------------------------------------------
Preschool_25_ABAS3_SPM2_cor_table <- bind_rows(
  Preschool_25_Stand_ABAS3_SPM2_cor_table,
  Preschool_25_Clin_ABAS3_SPM2_cor_table
  )

write_csv(Preschool_25_ABAS3_SPM2_cor_table,
          here(
            paste0(
              'OUTPUT-FILES/MANUAL-TABLES/t522-Preschool-ABAS3-SPM2-cor-',
              format(Sys.Date(), "%Y-%m-%d"),
              '.csv'
            )
          ),
          na = '')

rm(list = ls())

