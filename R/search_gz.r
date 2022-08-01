#' @name search_gz
#' @title Scan a gzipped file for text
#' @description Scans a zipped file for text
#' strings and returns TRUE if any are present.
#' @param terms Character vector; search terms (most likely GenBank accession
#' numbers)
#' @param path Path to the gzipped file to scan
#' @return Logical
#' @export
search_gz <- function(terms, path) {
  # Check platform and assign command accordingly
  if (.Platform$OS.type == "unix") {
    search_command <- "zgrep"
  } else if (.Platform$OS.type == "windows") {
    search_command <- "bash zgrep"
  } else {
    stop("Platform not unix or windows")
  }

  # There are a potentially large number of terms,
  # so grepping works best with external files
  temp_file <- tempfile()
  writeLines(terms, temp_file)
  # Run zgrep
  command <- paste(
    search_command,
    "-c -F -f",
    temp_file,
    path
  )
  # zgrep returns count of times any of the accessions occurred in the file
  search_res <- as.integer(
    suppressWarnings(system(command, intern = TRUE))
  )
  # Done with temp file
  unlink(temp_file)
  # Return TRUE if at least one accession found
  search_res > 0
}
