cems.createMessage <-
function(RESMNMT) {
    checkpkg("rjson")
    RESMNMT$relation <- NULL

    json <- toJSON(RESMNMT)
    return(json)
  }
