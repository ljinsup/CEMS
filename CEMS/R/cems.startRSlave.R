cems.startRSlave <-
function(injson, Service) {  
    # Debugging(injson, Service, text="startSlave(injson, Service_id): ")
    print("***************************************")
    print("*                                     *")
    print("*           Analysis Thread           *")
    print("*                                     *")
    print("***************************************")
    doc <- Service
    DBinfos <- Service$db_info
    checkpkg("rjson")
    inputMessage <<- fromJSON(injson)
    map <- data.frame()
    
    for(i in DBinfos) { 
      DBconnect <- connectMongo(Addr=Public_DB_Host,
                                DB=as.character(i$db),
                                port=Public_DB_Port)
      
      data <- getAllData(mongo=DBconnect, collection=as.character(i$collection), sort=i$order)
      data <- subset(data, select=as.character(i$attr))
      data <- as.data.frame(data)
      
      name <- paste(Service$service_id, i$collection, "data", sep=".")
      data <- cems.restoreDataType(data)
      
      assign(name, data, envir=.GlobalEnv)
      map <- rbind(map, name)
      destroyMongo(DBconnect)
    }
    names(map) <- c("data")
    assign(paste(Service$service_id, "map", sep="."), map, envir=.GlobalEnv)
    
    cems.startAnalysis(injson=injson, Service=Service)
  }
