# Linear Regression Function
#' Title
#'
#' @param x
#' @param y
#'
#' @return
#' @export
#'
#' @examples

linearRegression <- function(outcome_name, predictor_name, data){
  # Extracting the variables from the data
  y <- data[,outcome_name]
  x <- data[,predictor_name]
  # y <- data[,"Optimism"]
  # x <- data[,"Age"]
  # Adding a column of 1s for the intercept
  X <- cbind(1, x)

  # Calculating the coefficients using the formula: (X'X)^(-1)X'Y
  beta <- solve(t(X) %*% X) %*% t(X) %*% y

  # Calculating residuals (difference between observed and predicted values)
  residuals <- y - X %*% beta

  # Calculating standard error of coefficients
  n <- length(y)
  p <- ncol(X)
  df <- n - p
  sse <- sum(residuals^2)
  mse <- sse / df
  se_beta <- sqrt(diag(mse * solve(t(X) %*% X)))

  # Calculating t-values for coefficients
  t_values <- beta / se_beta

  # Calculating p-values for t-values
  p_values <- 2 * pt(-abs(t_values), df)

  # Calculating multiple R-squared
  ssr <- sum((X %*% beta - mean(y))^2)
  sst <- sum((y - mean(y))^2)
  r_squared <- ssr / sst

  # Calculating F-statistic
  f_statistic <- (ssr / (p - 1)) / (sse / df)

  # Calculating p-value for F-statistic
  p_value_f <- pf(f_statistic, p - 1, df, lower.tail = FALSE)

  # Creating a list to store the results
  results <- list(
    Residuals = fivenum(residuals),
    Coefficients = data.frame(Estimate = beta, Std.Error = se_beta, t_value = t_values, Pr = p_values),
    `Multiple R-squared` = r_squared,
    `F-statistic` = f_statistic,
    `p-value` = p_value_f
  )

  # Returning the results
  return(results)
}





