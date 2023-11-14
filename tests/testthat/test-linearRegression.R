test_that("multiplication works", {
  x <- matrix(c(1, 2, 3, 4), ncol = 1)
  y <- c(2, 3, 5, 4)
  m1 = lm(y~x)
  coefficients_vector <- unname(m1$coefficients)
  coefficients_matrix <- matrix(coefficients_vector, nrow = 1, ncol = length(coefficients_vector))
  expect_equal(linearRegression(x, y), coefficients_matrix)
})
