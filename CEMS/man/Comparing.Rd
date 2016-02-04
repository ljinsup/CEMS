\name{Comparing}
\alias{Comparing}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Comparing
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
Comparing(x, df)
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
    MEAN <- apply(df, 2, mean)
    MAX <- apply(df, 2, max)
    MIN <- apply(df, 2, min)
    if (x > MEAN) {
        res <- list(rate = (x - MEAN)/(MAX - MEAN) * 100)
    }
    else if (x < MEAN) {
        res <- list(rate = (MEAN - x)/(MEAN - MIN) * -100)
    }
    else {
        res <- list(rate = 0)
    }
    return(res)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
