source(here("CODE/ITEM-VECTORS/IT-49-Home-item-vectors.R"))

IT_49_Home_Clin <- bind_rows(
  suppressMessages(as_tibble(read_csv(
    here('OUTPUT-FILES/IT/T-SCORES-PER-CASE/IT-46-Home-clin-T-Scores-per-case.csv')
  ))),
  suppressMessages(as_tibble(read_csv(
    here('OUTPUT-FILES/IT/T-SCORES-PER-CASE/IT-79-Home-clin-T-Scores-per-case.csv')
  )))
) %>% 
  arrange(IDNumber)
