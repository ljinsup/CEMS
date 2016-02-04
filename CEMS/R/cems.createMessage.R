cems.createMessage <-
function(RESMNMT) {
    checkpkg("rjson")
    RESMNMT$relation <- NULL
    if(exists("rate", RESMNMT))
      RESMNMT$rate <- NULL
    if(exists("result", RESMNMT))
      RESMNMT$result <- NULL
    
    json <- toJSON(RESMNMT)
    return(json)
  }
