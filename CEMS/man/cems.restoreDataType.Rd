\name{cems.restoreDataType}
\alias{cems.restoreDataType}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{restoreDataType
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.restoreDataType(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
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
function (df) 
{
    temp <- data.frame()
    for (c in 1:length(df)) {
        if (!is.integer0(grep(x = as.character(df[1, c]), pattern = "([0-9]{4})[- .]([0-9]{1,2})[- .]([0-9]{1,2})[ ]([0-9]{1,2})[:]([0-9]{1,2})"))) {
            tryCatch({
                temp <- apply(df[c], 2, function(x) {
                  as.POSIXlt(as.character(x))
                })
                temp <- as.data.frame(temp)
                names(temp) <- c("DATETIME")
                df[c] <- temp
            }, error = function(e) {
                cat(paste("ERROR :", e))
            })
        }
        else if (!is.integer0(grep(x = as.character(df[1, c]), 
            pattern = "([0-9]+)[.]*([0-9]*)"))) {
            tryCatch({
                temp <- apply(df[c], 2, function(x) {
                  as.numeric(as.character(x))
                })
                temp <- as.data.frame(temp)
                names(temp) <- names(df)[c]
                df[c] <- temp
            }, error = function(e) {
                cat(paste("ERROR :", e))
            })
        }
        else {
            tryCatch({
                temp <- apply(df[c], 2, function(x) {
                  as.character(x)
                })
                temp <- as.data.frame(temp)
                names(temp) <- names(df)[c]
                df[c] <- temp
            }, error = function(e) {
                cat(paste("ERROR :", e))
            })
        }
    }
    return(df)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
