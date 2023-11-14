
<!-- README.md is generated from README.Rmd. Please edit that file -->

# linearRegression

<!-- badges: start -->

[![R-CMD-check](https://github.com/haoyi1102/hw3forBios625/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/haoyi1102/hw3forBios625/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/haoyi1102/hw3forBios625/branch/master/graph/badge.svg)](https://app.codecov.io/gh/haoyi1102/hw3forBios625?branch=master)
<!-- badges: end -->

The goal of linearRegression is to performing linear regression
analysis. This package allows users to easily compute linear regression
coefficients, residuals, standard errors, t-values, p-values, multiple
R-squared, F-statistic, and p-value for the F-statistic for any given
dataset.

## Installation

You can install the development version of linearRegression from
[GitHub](https://github.com/) with:

``` r
#install.packages("devtools") --> -->
devtools::install_github("haoyi1102/hw3forBios625")
#> Downloading GitHub repo haoyi1102/hw3forBios625@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>          checking for file 'C:\Users\24468\AppData\Local\Temp\Rtmp00Msv0\remotes1ca46fa94d41\haoyi1102-hw3forBios625-1b8be3f/DESCRIPTION' ...  ✔  checking for file 'C:\Users\24468\AppData\Local\Temp\Rtmp00Msv0\remotes1ca46fa94d41\haoyi1102-hw3forBios625-1b8be3f/DESCRIPTION' (425ms)
#>       ─  preparing 'linearRegression':
#>    checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>      NB: this package now depends on R (>=        NB: this package now depends on R (>= 3.5.0)
#>        WARNING: Added dependency on R >= 3.5.0 because serialized objects in
#>      serialize/load version 3 cannot be read in older versions of R.
#>      File(s) containing such objects:
#>      'linearRegression/data/testdata.RData'         'linearRegression/data/testdata.RData'
#> ─  building 'linearRegression_0.1.0.tar.gz'
#>      
#> 
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# Load the package
library(linearRegression)

#load example dataset
data <- data.frame(
  Outcome = c(1, 2, 3, 4, 5),
  Predictor = c(2, 3, 4, 5, 6)
)

#Perform linear regression
result <- linearRegression("Outcome", "Predictor", data)

#view the results
print(result)
#> $Residuals
#> [1] -8.881784e-16  0.000000e+00  0.000000e+00  4.440892e-16  8.881784e-16
#> 
#> $Coefficients
#>   Estimate    Std.Error       t_value           Pr
#>         -1 1.031970e-15 -9.690204e+14 2.423662e-45
#> x        1 2.432377e-16  4.111205e+15 3.173681e-47
#> 
#> $`Multiple R-squared`
#> [1] 1
#> 
#> $`F-statistic`
#> [1] 1.690201e+31
#> 
#> $`p-value`
#> [1] 3.173681e-47
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.
