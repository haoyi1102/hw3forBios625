#' Linear Regression Function
#'
#' This function performs a linear regression analysis on a given dataset.
#' It takes an outcome variable and a predictor variable from the dataset
#' and calculates the linear regression coefficients, residuals, standard errors,
#' t-values, p-values, multiple R-squared, F-statistic, and p-value for the F-statistic.
#' If the 'plot' parameter is set to TRUE, it also creates a plot of the
#' difference between studentized and standardized residuals versus
#' the standardized residuals.
#'
#' @param outcome_name The name of the outcome variable in the dataset.
#' @param predictor_name The name of the predictor variable in the dataset.
#' @param data The dataset containing the variables.
#' @param plot Logical, whether to plot the residuals. If TRUE, creates a plot
#'        showing the difference between studentized and standardized residuals
#'        against standardized residuals. The size of the dots in the plot
#'        depends on the leverage value for each observation.
#'
#' @return A list containing the following components:
#'   - Residuals: A numeric vector of five summary statistics of residuals (min, 1Q, median, 3Q, max).
#'   - Coefficients: A dataframe with estimates, standard errors, t-values, and p-values of the coefficients.
#'   - `Multiple R-squared`: The R-squared value of the model.
#'   - `F-statistic`: The F-statistic value of the model.
#'   - `p-value`: The p-value associated with the F-statistic.
#'
#' @export
#'
#' @examples
#' data(testdata)
#' result <- linearRegression("Optimism", "Age", data, plot = TRUE)
#' print(result)


linearRegression <-
  function(outcome_name, predictor_name, data, plot = FALSE) {
    # Extracting the variables from the data
    y <- data[, outcome_name]
    x <- data[, predictor_name]
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
    sse <- sum(residuals ^ 2)
    mse <- sse / df
    se_beta <- sqrt(diag(mse * solve(t(X) %*% X)))

    # Calculating t-values for coefficients
    t_values <- beta / se_beta

    # Calculating p-values for t-values
    p_values <- 2 * pt(-abs(t_values), df)

    # Calculating multiple R-squared
    ssr <- sum((X %*% beta - mean(y)) ^ 2)
    sst <- sum((y - mean(y)) ^ 2)
    r_squared <- ssr / sst

    # Calculating F-statistic
    f_statistic <- (ssr / (p - 1)) / (sse / df)

    # Calculating p-value for F-statistic
    p_value_f <- pf(f_statistic, p - 1, df, lower.tail = FALSE)

    # Creating a list to store the results
    results <- list(
      Residuals = fivenum(residuals),
      Coefficients = data.frame(
        Estimate = beta,
        Std.Error = se_beta,
        t_value = t_values,
        Pr = p_values
      ),
      `Multiple R-squared` = r_squared,
      `F-statistic` = f_statistic,
      `p-value` = p_value_f
    )

    # Creating a plot if 'plot' is TRUE
    if (plot) {
      # Calculating standardized residuals
      std_residuals <- residuals / sqrt(sum(residuals ^ 2) / df)

      # Calculating studentized residuals using the rstudent() function
      lm_model <- lm(y ~ x)
      stud_residuals <- rstudent(lm_model)

      # Calculating leverage values using the hatvalues() function
      hii <- hatvalues(lm_model)

      # Plotting the scatter plot using the base R plot function
      plot(
        std_residuals,
        stud_residuals - std_residuals,
        xlab = "Standardized Residuals",
        ylab = "Difference Between Studentized and Standardized Residuals",
        main = "Plot of Residuals"
      )
      # Adding points to the plot with size proportional to leverage values
      points(
        std_residuals,
        stud_residuals - std_residuals,
        pch = 20,
        cex = sqrt(hii) * 2
      )
    }

    # Returning the results
    return(results)
  }
