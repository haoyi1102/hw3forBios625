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
linearRegression <- function(x, y) {
  # Adding a column of 1s for the intercept
  X <- cbind(1, x)

  # Calculating the coefficients
  beta <- solve(t(X) %*% X) %*% t(X) %*% y

  return(t(beta))
}
# Example usage of the function
# x <- matrix(c(1, 2, 3, 4), ncol = 1) # Predictor variable
# y <- c(2, 3, 5, 4)                   # Response variable
#
# coefficients <- linearRegression(x, y)
# print(coefficients)

