\name{Counting}
\alias{Counting}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Counting
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
Counting(x, df)
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
    data <- subset(x = df, select = names(x))
    data <- na.omit(data)
    x <- DataForming(as.data.frame(x))
    data <- DataForming(as.data.frame(data))
    data <- count(data)
    per <- data$freq/sum(data$freq) * 100
    names(per) <- "per"
    data$per <- per
    for (i in 1:nrow(data)) {
        if (is.include(x, data[i, 1:length(x)])) {
            return(list(rate = data[i, "per"]))
        }
        if (i == nrow(data)) 
            stop("No data")
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
