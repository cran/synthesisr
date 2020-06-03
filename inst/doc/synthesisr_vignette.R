## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# system.file will look for the path to where synthesisr is installed
# by using the example bibliographic data files, you can reproduce the vignette
bibfiles <- list.files(
  system.file("extdata/", package = "synthesisr"),
  full.names = TRUE
)

# we can print the list of bibfiles to confirm what we will import
# in this example, we have bibliographic data exported from Scopus and Zoological Record
print(bibfiles)

# now we can use read_refs to read in our bibliographic data files
# we save them to a data.frame object (because return_df=TRUE) called imported_files
library(synthesisr)
imported_files <- read_refs(
  filename = bibfiles,
  return_df = TRUE)


## -----------------------------------------------------------------------------
# first, we will remove articles that have identical titles
# this is a fairly conservative approach, so we will remove them without review
df <- deduplicate(
  imported_files,
  match_by = "title",
  method = "exact"
)


## -----------------------------------------------------------------------------
# there are still some duplicate articles that were not removed
# for example, the titles for articles 91 and 114 appear identical
df$title[c(91,114)]
# the dash-like symbol in title 91, however, is a special character not punctuation
# so it was not classified as identical

# similarly, there is a missing space in the title for article 96
df$title[c(21,96)]

# and an extra space in title 47
df$title[c(47, 101)]

# in this example, we will use string distance to identify likely duplicates
duplicates_string <- find_duplicates(
  df$title,
  method = "string_osa",
  to_lower = TRUE,
  rm_punctuation = TRUE,
  threshold = 7
)

# we can extract the line numbers from the dataset that are likely duplicated
# this lets us manually review those titles to confirm they are duplicates

manual_checks <- review_duplicates(df$title, duplicates_string)


## ---- include=FALSE, eval=TRUE------------------------------------------------
manual_checks[,1] <- substring(manual_checks[,1], 1, 60)
manual_checks

## -----------------------------------------------------------------------------
print(manual_checks)

# the titles under match #99 are not duplicates, so we need to keep them both
# we can use the override_duplicates function to manually mark them as unique
new_duplicates <- synthesisr::override_duplicates(duplicates_string, 99)

# now we can extract unique references from our dataset
# we need to pass it the dataset (df) and the matching articles (new_duplicates)
results <- extract_unique_references(df, new_duplicates)


## ----paged.print=TRUE---------------------------------------------------------

# synthesisr can write the full dataset to a bibliographic file
# but in this example, we will just write the first citation
# we also want it to be a nice clean bibliographic file, so we remove NA data
# this makes it easier to view the output when working with a single article
citation <- df[1,!is.na(df[1,])]

format_citation(citation)

write_refs(citation,
  format = "bib",
  file = FALSE
)


