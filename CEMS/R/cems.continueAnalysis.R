cems.continueAnalysis <-
function(injson, Service, index) { 
    #   Debugging(injson, Service_id, index, text="AnalyzeResume(injson, service_id, index): ")
    DBinfos <- Service$db_info
    Analysislist <- Service$analysis
    
    json <- fromJSON(injson)
    
    map <- get(paste(Service$service_id, "map", sep="."))
    
    
    for(i in Analysislist){
      if(as.numeric(index) == as.numeric(i$no)){
        Analysis <- i
        break
      }   
    }
    #################################################################
    for(a in Analysis$public) {
      if(a == ""){break}
      
      for(m in map$data){
        data <- get(as.character(m))
        if(is.include(a, names(m))) {
          break
        }
      }
    }
    
    json <- json$sensors_data
    json <- as.list(unlist(json))
    json[!names(json) %in% Analysis$sensor] <- NULL
    
    #==================================================#
    # Call Analysis Function & Parameters
    #==================================================#
    func <- get(as.character(Analysis$method)) 
    
    if(exists("parameter", where=Analysis))
    {
      value <- func(json, data, Analysis$parameter)
    }
    else {
      value <- func(json, data)
      
    }
    cems.manageResult(Service=Service, value=value, relationvalue=index)
  }
