% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validate.R
\name{get_val2}
\alias{get_val2}
\title{Get value or return default if invalid}
\usage{
get_val2(x, key = NA, default = NULL, na = FALSE, min_len = 1L, ...)
}
\arguments{
\item{x}{a list, or environment, or just any R object}

\item{key}{the name to obtain from \code{x}. If \code{NA}, then
return x. Default is \code{NA}}

\item{default}{default value if}

\item{na, min_len, ...}{passed to \code{\link{is_valid_ish}}}
}
\value{
values of the keys or default is invalid
}
\description{
Get value or return default if invalid
}
\examples{

x <- list(a=1, b = NA, c = character(0))

# ------------------------ Basic usage ------------------------

# no key, returns x if x is valid
get_val2(x)

get_val2(x, 'a', default = 'invalid')



# get 'b', NA is not filtered out
get_val2(x, 'b', default = 'invalid')

# get 'b', NA is considered invalid
get_val2(x, 'b', default = 'invalid', na = TRUE)



# get 'c', length 0 is allowed
get_val2(x, 'c', default = 'invalid', min_len = 0)

# length 0 is forbidden
get_val2(x, 'c', default = 'invalid', min_len = 1)


}
