
# Test case for comparing the results of the custom linearRegression function
# with the built-in lm function in R
test_that("linearRegression matches lm function results", {

  # Load test data
  data("testdata")

  # Run the custom linear regression function
  m <- linearRegression("Optimism", "Age", data)

  # Run the built-in lm function and summarize it
  m1 <- summary(lm(Optimism ~ Age, data))

  # Compare Residuals
  # Expect the residuals from the custom model to match the five-number summary of lm model residuals
  expect_equal(m$Residuals, as.vector(fivenum(m1$residuals)))

  # Compare Coefficients
  # Extract coefficients from the custom model
  custom_coeffs <- m$Coefficients$Estimate

  # Extract coefficients from the lm model summary
  lm_coeffs <- m1$coefficients[, "Estimate"]

  # Expect the coefficients from the custom model to match those from the lm model
  expect_equal(custom_coeffs, as.vector(lm_coeffs))

  # Compare Multiple R-squared
  # Expect the Multiple R-squared from the custom model to match that from the lm model
  expect_equal(m$`Multiple R-squared`, m1$r.squared)

  # Compare F-statistic
  # Expect the F-statistic from the custom model to match that from the lm model
  expect_equal(m$`F-statistic`, as.vector(m1$fstatistic[1]))

  # Compare p-value of F-statistic
  # Calculate p-value for F-statistic from the lm model
  p_value_f_lm <- pf(m1$fstatistic[1], m1$fstatistic[2], m1$fstatistic[3], lower.tail = FALSE)

  # Expect the p-value from the custom model to match the calculated p-value from the lm model.
  expect_equal(m$`p-value`, as.vector(p_value_f_lm))

  # Invoking the linearRegression function with parameters 'Optimism', 'Age', and a data frame 'data'.
  # The 'plot = TRUE' argument is set, indicating that the function should generate a plot.
  linearRegression("Optimism", "Age", data, plot = TRUE)

  # The recordPlot function captures the last plot that was produced.
  # It is used here to record the plot output from the linearRegression function call.
  plot_record <- recordPlot()

  # The test checks if a plot was indeed created by verifying that the recorded plot object has a non-zero length.
  # The expect_true function from the testthat package is used for this assertion.
  # If a plot was created, plot_record will have elements, and its length will be greater than zero.
  expect_equal(length(plot_record) > 0,TRUE)

})
