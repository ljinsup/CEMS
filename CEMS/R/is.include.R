is.include <-
function(x, group) {
    array <- x %in% group
    
    for(b in array) {
      if(!b)return(FALSE)
    }
    return(TRUE)
  }
