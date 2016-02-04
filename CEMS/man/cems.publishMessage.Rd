\name{cems.publishMessage}
\alias{cems.publishMessage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{publishMessage
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
cems.publishMessage(json_str)
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
    checkpkg("rJava")
    ip <- MQTT_Server_Host
    port <- MQTT_Server_Port
    key <- Key
    JSON <- fromJSON(json_str)
    if (JSON$type == "act") {
        topic <- paste(key, JSON$type, input$tg_id, sep = "/")
        msg <- json_str
    }
    else if (JSON$type == "push") {
        topic <- paste(key, JSON$type, JSON$id, sep = "/")
        msg <- JSON$message
    }
    .jinit("./MQTTPublisher.jar")
    mqtt <- .jnew("mqtt/MqttSend")
    mqtt$SEND(ip, port, topic, msg)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
