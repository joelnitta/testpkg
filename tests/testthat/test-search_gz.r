library(testthat)

writeLines(c("this", "is", "some", "text"), "test.txt")

test_that("search works", {
  expect_true(search_gz("is", "test.txt"))
  expect_false(search_gz("isa", "test.txt"))
})

unlink("test.txt")
