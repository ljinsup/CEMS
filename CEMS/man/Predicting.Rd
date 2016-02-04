\name{Predicting}
\alias{Predicting}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Predicting
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
Predicting(x, df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{df}{
%%     ~~Describe \code{df} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x, df) 
{
    value <- as.numeric(x)
    df <- df
    m <- arima(df)
    predictvalue <- as.numeric(predict(m)$pred)
    publicvalue <- df[nrow(df), ]
    list <- list()
    if (max(value, predictvalue, publicvalue) == value) {
        result <- 1
    }
    else if (min(value, predictvalue, publicvalue) == value) {
        result <- 3
    }
    else {
        result <- 2
    }
    if (publicvalue - predictvalue < 0) {
        list <- list(result = result)
    }
    else {
        list <- list(result = result + 3)
    }
    return(list)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
