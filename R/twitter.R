create_token_no_browser <- function(
  app_name,
  consumer_key,
  consumer_secret,
  access_token,
  access_secret
) {
  app <- httr::oauth_app(app_name, consumer_key, consumer_secret)
  params <- list(as_header = TRUE)
  credentials <- list(oauth_token = access_token,
                      oauth_token_secret = access_secret)
  token <- httr::Token1.0$new(
    endpoint = httr::oauth_endpoints("twitter"),
    params = params,
    app = app,
    credentials = credentials
  )
  return(token)
}

#' Title
#'
#' @return
#' @export
twitter_authenticate <- function() {
  token <- create_token_no_browser(
    Sys.getenv("TWITTER_APP_NAME"),
    Sys.getenv("TWITTER_CONSUMER_KEY"),
    Sys.getenv("TWITTER_CONSUMER_SECRET"),
    Sys.getenv("TWITTER_ACCESS_TOKEN"),
    Sys.getenv("TWITTER_ACCESS_SECRET")
  )

  # Save token so that it's picked up by {rtweet}.
  #
  TOKEN_RDS <- tempfile(fileext = ".rds")
  saveRDS(token, file = TOKEN_RDS, compress = FALSE)
  Sys.setenv(TWITTER_PAT = TOKEN_RDS)
}
