\name{cems.continueAnalysis}
\alias{cems.continueAnalysis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{continueAnalysis
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.continueAnalysis(injson, Service, index)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{injson}{
%%     ~~Describe \code{injson} here~~
}
  \item{Service}{
%%     ~~Describe \code{Service} here~~
}
  \item{index}{
%%     ~~Describe \code{index} here~~
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
function (injson, Service, index) 
{
    DBinfos <- Service$db_info
    Analysislist <- Service$analysis
    json <- fromJSON(injson)
    map <- get(paste(Service_id, "map", sep = "."))
    for (i in Analysislist) {
        if (as.numeric(index) == as.numeric(i$no)) {
            Analysis <- i
            break
        }
    }
    for (a in Analysis$public) {
        if (a == "") {
            break
        }
        for (m in map$data) {
            data <- get(as.character(m))
            if (is.include(a, names(m))) {
                break
            }
        }
    }
    json <- json$sensors_data
    json <- as.list(unlist(json))
    json[!names(json) \%in\% Analysis$sensor] <- NULL
    func <- get(as.character(Analysis$method))
    if (exists("parameter", where = Analysis)) {
        value <- func(json, data, Analysis$parameter)
    }
    else {
        value <- func(json, data)
    }
    cems.manageResult(Service = Service, value = value, relationvalue = index)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
