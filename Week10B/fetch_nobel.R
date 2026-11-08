# fetch_nobel.R ----------------------------------------------------------
# Downloads every Nobel laureate from the Nobel Prize API (v2.1), flattens the
# nested JSON into two tidy data frames, and saves them as a dated snapshot.
#
# Run from the Week10B folder:  Rscript fetch_nobel.R
#
# The API is public and needs no key.
# Terms of use: https://www.nobelprize.org/about/terms-of-use-for-api-nobelprize-org-and-data-nobelprize-org/

suppressPackageStartupMessages({
  library(httr2); library(jsonlite); library(dplyr); library(purrr)
  library(tibble); library(readr); library(rlang)
})

BASE  <- "https://api.nobelprize.org/2.1/laureates"
LIMIT <- 100          # records per request
PAUSE <- 1            # seconds between requests, to stay polite

get_page <- function(offset) {
  resp <- request(BASE) |>
    req_url_query(limit = LIMIT, offset = offset) |>
    req_error(is_error = \(r) FALSE) |>
    req_perform()
  Sys.sleep(PAUSE)
  if (resp_status(resp) != 200) {
    message("  offset ", offset, " -> HTTP ", resp_status(resp))
    return(NULL)
  }
  resp_body_json(resp)
}

# First call also tells us how many records there are in total.
first <- get_page(0)
total <- first$meta$count
message("Total laureates reported by the API: ", total)

pages   <- list(first)
offsets <- seq(LIMIT, total, by = LIMIT)
for (off in offsets) {
  message("Fetching offset ", off)
  pages[[length(pages) + 1]] <- get_page(off)
}

laureates_raw <- pages |> compact() |> map("laureates") |> list_flatten()
message("Records retrieved: ", length(laureates_raw))

# English label from a multi-language field, e.g. {en: "USA", se: "USA"}
en <- function(x) if (is.null(x)) NA_character_ else (x[["en"]] %||% NA_character_)

# First non-missing value. Needed because en() returns NA (not NULL) for an
# absent field, and %||% only catches NULL: organizations have orgName where
# people have knownName, so the fallback must treat NA as "try the next one".
first_present <- function(...) {
  vals <- c(...)
  vals <- vals[!is.na(vals)]
  if (length(vals)) vals[[1]] else NA_character_
}

# One row per laureate (people and organizations both).
laureates <- map_dfr(laureates_raw, \(l) tibble(
  laureate_id     = l$id,
  name            = first_present(en(l$knownName), en(l$orgName)),
  is_organization = !is.null(l$orgName),
  gender          = l$gender %||% NA_character_,
  birth_date      = first_present(l$birth$date %||% NA_character_, l$founded$date %||% NA_character_),
  birth_country   = first_present(en(l$birth$place$country), en(l$founded$place$country)),
  birth_country_now = first_present(en(l$birth$place$countryNow), en(l$founded$place$countryNow)),
  birth_continent = en(l$birth$place$continent)  %||% NA_character_,
  death_date      = l$death$date %||% NA_character_,
  n_prizes        = length(l$nobelPrizes)
))

# One row per laureate per prize: a two-time winner produces two rows.
prizes <- map_dfr(laureates_raw, \(l) {
  map_dfr(l$nobelPrizes, \(p) {
    aff <- if (length(p$affiliations)) p$affiliations[[1]] else NULL
    tibble(
      laureate_id          = l$id,
      name                 = first_present(en(l$knownName), en(l$orgName)),
      award_year           = as.integer(p$awardYear),
      category             = en(p$category),
      portion              = p$portion %||% NA_character_,
      prize_status         = p$prizeStatus %||% NA_character_,
      prize_amount_adjusted = p$prizeAmountAdjusted %||% NA_integer_,
      affiliation_name     = if (is.null(aff)) NA_character_ else en(aff$name),
      affiliation_country  = if (is.null(aff)) NA_character_ else en(aff$country),
      affiliation_country_now = if (is.null(aff)) NA_character_ else en(aff$countryNow),
      n_affiliations       = length(p$affiliations)
    )
  })
})

write_csv(laureates, "data/nobel_laureates.csv")
write_csv(prizes,    "data/nobel_prizes.csv")

message("\nSaved ", nrow(laureates), " laureates and ", nrow(prizes), " laureate-prize rows.")
