context("testing epmc_db")

test_that("epmc_db returns", {
  skip_on_cran()
  # as of July 2024, this result only returns 10 results, so limit must
  # be <= that
  a_limit <- 7
  a <- epmc_db("12368864", db = "uniprot", limit = a_limit)
  b <- epmc_db("25249410", db = "embl")
  c <- epmc_db("14756321", db = "uniprot")
  d <- epmc_db("11805837", db = "pride")
  e <- epmc_db("10676951", db = "ARXPR")

  #correct dimensions and class
  expect_output(str(a), "data.frame")
  expect_output(str(b), "data.frame")
  expect_output(str(c), "data.frame")
  expect_output(str(d), "data.frame")
  expect_output(str(e), "data.frame")

  expect_output(str(a), "tbl_df")
  expect_output(str(b), "tbl_df")
  expect_output(str(c), "tbl_df")
  expect_output(str(d), "tbl_df")
  expect_output(str(e), "tbl_df")



  expect_is(attr(a, "hit_count"), "integer")
  expect_is(attr(b, "hit_count"), "integer")
  expect_is(attr(c, "hit_count"), "integer")
  expect_is(attr(d, "hit_count"), "integer")
  expect_is(attr(e, "hit_count"), "integer")



  expect_equal(nrow(a), a_limit)

  # fails correctly
  expect_error(epmc_db("14756321"), "Please restrict reponse to a database")
  expect_message(epmc_db("14756321", db = "intact"), "No links found")
  expect_equal(nrow(epmc_db("14756321", db = "intact")), 0)
  expect_error(epmc_db("13814508", data_src = "abc"))
  expect_error(epmc_db("14756321", db = "uniprotl"))
  expect_error(epmc_db("12368864", db = "uniprot", limit = "no"))
})
