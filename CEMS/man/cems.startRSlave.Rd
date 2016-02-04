\name{cems.startRSlave}
\alias{cems.startRSlave}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{startRSlave
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.startRSlave(injson, Service)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{injson}{
%%     ~~Describe \code{injson} here~~
}
  \item{Service}{
%%     ~~Describe \code{Service} here~~
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
function (injson, Service) 
{
    Debugging(injson, Service, text = "startSlave(injson, Service_id): ")
    print("***************************************")
    print("*                                     *")
    print("*           Analysis Thread           *")
    print("*                                     *")
    print("***************************************")
    doc <- Service
    DBinfos <- Service$db_info
    map <- data.frame()
    for (i in DBinfos) {
        DBconnect <- connectMongo(Addr = Public_DB_Host, DB = as.character(i$db), 
            port = Public_DB_Port)
        data <- getAllData(mongo = DBconnect, collection = as.character(i$collection), 
            sort = as.character(i$order))
        data <- subset(data, select = as.character(i$attr))
        data <- as.data.frame(data)
        name <- paste(Service_id, i$collection, "data", sep = ".")
        data <- cems.restoreDataType(data)
        assign(name, data, envir = .GlobalEnv)
        map <- rbind(map, name)
        destroyMongo(DBconnect)
    }
    names(map) <- c("data")
    assign(paste(Service_id, "map", sep = "."), map, envir = .GlobalEnv)
    cems.startAnalysis(injson = injson, Service = Service)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
