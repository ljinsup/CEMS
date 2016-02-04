\name{cems.manageResult}
\alias{cems.manageResult}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{manageResult
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.manageResult(Service, value, relationvalue)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Service}{
%%     ~~Describe \code{Service} here~~
}
  \item{value}{
%%     ~~Describe \code{value} here~~
}
  \item{relationvalue}{
%%     ~~Describe \code{relationvalue} here~~
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
function (Service, value, relationvalue) 
{
    list <- list()
    Resmnmt <- Service$resultmnmt
    if (exists("result", where = value)) {
        for (RES in Resmnmt) {
            if (relationvalue == as.character(RES$relation) && 
                is.include(value, RES$result)) {
                list <- append(list, list(RES))
            }
        }
    }
    else if (exists("rate", where = value)) {
        for (RES in Resultmnmt) {
            if (relationvalue == as.character(RES$relation) && 
                value$rate > as.numeric(unlist(strsplit(RES$rate, 
                  split = " "))[1]) && value$rate <= as.numeric(unlist(strsplit(RES$rate, 
                split = " "))[2])) {
                list <- append(list, list(RES))
            }
        }
    }
    if (length(list) == 0) {
        cems.clear(Service_id)
        return
    }
    for (l in list) {
        if (l$type == "act") {
            print("Action MQTT")
            cems.publishMessage(cems.createMessage(l))
        }
        else if (l$type == "push") {
            print("Push Message")
            cems.publishMessage(cems.createMessage(l))
        }
        else if (l$type == "next") {
            print("Next Analysis")
            cems.continueAnalysis(injson = "input", Service = Service, 
                index = l$NO)
        }
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
