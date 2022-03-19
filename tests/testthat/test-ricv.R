test_that("invalid attributes name given to options cause stop", {
  testthat::expect_error(new_Options(list(blabla=1)))
  testthat::expect_error(new_Options(list(hello=T)))
})

test_that("options can only be a list or NULL", {
  testthat::expect_error(new_Options(3),
                         "options must be a list or NULL")
  testthat::expect_error(new_Options(c(T,F)),
                         "options must be a list or NULL")
  testthat::expect_error(new_Options(c(controlColor = T)),
                         "options must be a list or NULL")
  testthat::expect_equal(new_Options(NULL), list())
  testthat::expect_equal(new_Options(list()), list())
})

test_that("invalid attribute value given to options causes stop", {
  testthat::expect_error(new_Options(list(controlColor=T)),
                         "controlColor in options should be a single element of type character but is a logical")
  testthat::expect_error(new_Options(list(addCircle="text")),
                         "addCircle in options should be a single element of type logical but is a character")
  testthat::expect_error(new_Options(list(addCircle=c(T,T))),
                         "addCircle in options should be a single element but is made of 2 values")
})
