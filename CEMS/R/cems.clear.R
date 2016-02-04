cems.clear <-
function(Service_id) {  
    rm(list=ls(name=.GlobalEnv))    
    message("Environment Clear")
  }
