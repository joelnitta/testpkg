library(testthat)

test_that("search works", {
  expect_true(search_gz(
    "is",
    system.file("extdata", "test.gz", package = "testpkg")
    ))
  expect_false(search_gz(
    "isnot",
    system.file("extdata", "test.gz", package = "testpkg")
    ))
})
