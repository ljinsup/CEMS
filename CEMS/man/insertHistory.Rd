\name{insertHistory}
\alias{insertHistory}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{insertHistory
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
insertHistory(type, list)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{type}{
%%     ~~Describe \code{type} here~~
}
  \item{list}{
%%     ~~Describe \code{list} here~~
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
function (type, list) 
{
    mongo <- connectMongo(Addr = "127.0.0.1", DB = "history", 
        port = 50000)
    list$TYPE <- type
    list$TIME <- as.character(Sys.time())
    ns <- paste(attr(mongo, "db"), toupper(list$TYPE), sep = ".")
    mongo.insert(mongo, ns, mongo.bson.from.list(list))
    destroyMongo(mongo)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
