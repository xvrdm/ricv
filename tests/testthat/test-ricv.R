test_that("invalid attributes name given to options cause stop", {
  testthat::expect_error(ricv(img1 = "", img2 = "", options = list(blabla=1)))
  testthat::expect_error(ricv(img1 = "", img2 = "", options = list(hello=T)))
})

test_that("invalid attribute value given to options causes stop", {
  testthat::expect_error(ricv(img1 = "", img2 = "", options = list(controlColor=T)),
                         "controlColor in options should be a single element of type character but is a logical")
  testthat::expect_error(ricv(img1 = "", img2 = "", options = list(addCircle="text")),
                         "addCircle in options should be a single element of type logical but is a character")
  testthat::expect_error(ricv(img1 = "", img2 = "", options = list(addCircle=c(T,T))),
                         "addCircle in options should be a single element but is made of 2 values")
})
