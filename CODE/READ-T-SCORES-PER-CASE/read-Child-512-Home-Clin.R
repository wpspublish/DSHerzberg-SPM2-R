source(here("CODE/ITEM-VECTORS/Child-512-Home-item-vectors.R"))

Child_512_Home_Clin <-
  suppressMessages(as_tibble(read_csv(
    here("OUTPUT-FILES/CHILD/T-SCORES-PER-CASE/Child-512-Home-clin-T-Scores-per-case.csv")
  )))

