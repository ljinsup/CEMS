cems.restoreDataType <-
function(df) {
    #   Debugging(df, text="Data.Forming(df): ")
    temp <- data.frame()
    for(c in 1:length(df)) {
      if(!is.integer0(grep(x=as.character(df[1, c]),
                           pattern="([0-9]{4})[- .]([0-9]{1,2})[- .]([0-9]{1,2})[ ]([0-9]{1,2})[:]([0-9]{1,2})"))) {
        #DATETIME
        tryCatch({
          temp <- apply(df[c], 2, function(x){ as.POSIXlt(as.character(x)) } )
          
          temp <- as.data.frame(temp)
          names(temp) <- c("DATETIME")
          df[c] <- temp
        }, error=function(e){
          cat(paste("ERROR :", e))
        })        
      }
      else if(!is.integer0(grep(x=as.character(df[1, c]),
                                pattern="([0-9]+)[.]*([0-9]*)"))) {
        #NUMERIC
        tryCatch({
          temp <- apply(df[c], 2, function(x){ as.numeric(as.character(x))})
          temp <- as.data.frame(temp)
          names(temp) <- names(df)[c]
          df[c] <- temp
        }, error=function(e){
          cat(paste("ERROR :", e))
        })        
      }
      else {
        #CHARACTER
        tryCatch({
          temp <- apply(df[c], 2, function(x){ as.character(x)})
          temp <- as.data.frame(temp)
          names(temp) <- names(df)[c]
          df[c] <- temp
        }, error=function(e){
          cat(paste("ERROR :", e))
        })
      }
    }
    return(df)
  }
