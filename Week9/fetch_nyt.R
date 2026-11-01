# fetch_nyt.R ------------------------------------------------------------
# Pulls NYT Article Search results for one topic across two six-month periods
# and saves a dated snapshot so the report is reproducible without an API key.
#
# Run from the Week9 folder:  Rscript fetch_nyt.R
#
# The API key is read from ~/.Renviron (NYT_API_KEY) and never written to disk.

suppressPackageStartupMessages({
  library(httr2); library(dplyr); library(purrr); library(tibble); library(readr); library(rlang)
})

api_key <- Sys.getenv("NYT_API_KEY")
stopifnot(nzchar(api_key))

TOPIC     <- "artificial intelligence"
PERIODS   <- c(2019, 2026)     # January-June of each year
MONTHS    <- 1:6
PAGES     <- 0:1               # 2 pages = up to 20 articles per month
PAUSE     <- 13                # seconds; the API allows ~5 requests per minute

month_bounds <- function(year, month) {
  start <- as.Date(sprintf("%d-%02d-01", year, month))
  end   <- seq(start, by = "1 month", length.out = 2)[2] - 1
  c(format(start, "%Y%m%d"), format(end, "%Y%m%d"))
}

search_page <- function(year, month, page) {
  b <- month_bounds(year, month)
  resp <- request("https://api.nytimes.com/svc/search/v2/articlesearch.json") |>
    req_url_query(q = TOPIC, begin_date = b[1], end_date = b[2],
                  page = page, `api-key` = api_key) |>
    req_error(is_error = \(r) FALSE) |>
    req_perform()
  Sys.sleep(PAUSE)
  if (resp_status(resp) != 200) {
    message("  page ", page, " -> HTTP ", resp_status(resp))
    return(NULL)
  }
  resp_body_json(resp)$response
}

all_docs <- list(); totals <- list()

for (yr in PERIODS) for (mo in MONTHS) {
  message("Fetching ", yr, "-", sprintf("%02d", mo))
  for (pg in PAGES) {
    res <- search_page(yr, mo, pg)
    if (is.null(res)) next
    if (pg == 0) {
      totals[[length(totals) + 1]] <-
        tibble(year = yr, month = mo, total_hits = res$meta$hits)
      message("  hits: ", res$meta$hits)
    }
    if (length(res$docs) == 0) next
    all_docs[[length(all_docs) + 1]] <- map_dfr(res$docs, \(d) tibble(
      # Nested fields are pulled out here; %||% guards against missing pieces.
      headline         = d$headline$main            %||% NA_character_,
      byline           = d$byline$original          %||% NA_character_,
      section_name     = d$section_name             %||% NA_character_,
      subsection_name  = d$subsection_name          %||% NA_character_,
      news_desk        = d$news_desk                %||% NA_character_,
      type_of_material = d$type_of_material         %||% NA_character_,
      pub_date         = d$pub_date                 %||% NA_character_,
      word_count       = d$word_count               %||% NA_integer_,
      n_keywords       = length(d$keywords),
      keywords         = paste(map_chr(d$keywords, \(k) k$value %||% NA_character_),
                               collapse = "; "),
      web_url          = d$web_url                  %||% NA_character_,
      query_year       = yr,
      query_month      = mo
    ))
  }
}

articles <- bind_rows(all_docs)
monthly  <- bind_rows(totals)

write_csv(articles, "data/nyt_ai_articles.csv")
write_csv(monthly,  "data/nyt_ai_monthly_totals.csv")

message("\nSaved ", nrow(articles), " articles and ", nrow(monthly), " monthly totals.")
