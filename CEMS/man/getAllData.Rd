\name{getAllData}
\alias{getAllData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{getAllData
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
getAllData(mongo, collection, sort = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mongo}{
%%     ~~Describe \code{mongo} here~~
}
  \item{collection}{
%%     ~~Describe \code{collection} here~~
}
  \item{sort}{
%%     ~~Describe \code{sort} here~~
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
function (mongo, collection, sort = NULL) 
{
    checkpkg("plyr")
    res.frame <- data.frame()
    if (mongo.is.connected(mongo)) {
        if (!is.null(sort)) {
            cursor <- mongo.find(mongo = mongo, ns = paste(attr(mongo, 
                "db"), as.character(collection), sep = "."), 
                query = mongo.bson.empty(), sort = mongo.bson.from.JSON(paste("{\"", 
                  sort, "\" : 1}", sep = "")), fields = "{\"_id\":0}")
        }
        else {
            cursor <- mongo.find(mongo = mongo, ns = paste(attr(mongo, 
                "db"), as.character(collection), sep = "."), 
                query = mongo.bson.empty(), sort = mongo.bson.empty(), 
                fields = "{\"_id\":0}")
        }
        if (mongo.cursor.next(cursor)) {
            res <- mongo.cursor.value(cursor)
            res <- mongo.bson.to.list(res)
            res.frame <- as.data.frame(res)
            while (mongo.cursor.next(cursor)) {
                res <- mongo.cursor.value(cursor)
                res <- mongo.bson.to.list(res)
                res <- as.data.frame(res)
                res.frame <- rbind.fill(res.frame, res)
            }
        }
        else {
            stop("No Data")
        }
    }
    if (length(res.frame) == 0) 
        return(data.frame())
    else return(res.frame)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
