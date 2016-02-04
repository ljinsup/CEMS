\name{cems.startRMaster}
\alias{cems.startRMaster}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{startRMaster
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.startRMaster(json_str)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{json_str}{
%%     ~~Describe \code{json_str} here~~
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
function (json_str) 
{
    cems.init()
    print("****************************************")
    print("*                                      *")
    print("*            Analysis Start            *")
    print("*                                      *")
    print("****************************************")
    input <- fromJSON(json_str)
    data <- as.list(unlist(input$sensors_data))
    tg_id <- input$tg_id
    TG_DB <- connectMongo(Addr = User_DB_Host, DB = User_DB_Name)
    service <- mongo.get.values(mongo, paste(attr(TG_DB, "db"), 
        tg_id, sep = "."), "service")
    list <- ls(envir = .GlobalEnv)
    if (length(service) == 0) 
        stop("Not Maching Service")
    log <- list()
    log$service <- service
    log$LOG <- "service"
    for (servicedata in service) {
        if (!is.integer0(grep(x = nodelist[[1]], pattern = "[:]"))) {
            rs <- RS.connect(host = unlist(strsplit(unlist(nodelist), 
                split = ":"))[1], port = unlist(strsplit(unlist(nodelist), 
                split = ":"))[2])
        }
        else {
            rs <- RS.connect(host = nodelist[[1]])
        }
        RS.eval(rs, require(CEMS))
        RS.eval(rs, CEMS::.init())
        for (name in list) {
            RS.assign(rs, name, get(name))
        }
        RS.assign(rs, "json_str", json_str)
        RS.assign(rs, "Service", servicedata)
        RS.eval(rs, x = cems.startRSlave(injson = json_str, Service = servicedata), 
            wait = FALSE)
        RS.close(rs)
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
