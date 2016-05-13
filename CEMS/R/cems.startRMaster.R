cems.startRMaster <-
function (json_str) {
    # 초기화
    cems.init()
    print("Input Sensor Data")
    print(json_str)
    #   Debugging(json_str, text="startMaster(json_str): ")
    print("****************************************")
    print("*                                      *")
    print("*            Analysis Start            *")
    print("*                                      *")
    print("****************************************")
    
    # input JSON assign
    input <- fromJSON(json_str)
    data <- as.list(unlist(input$sensors_data))
    tg_id <- input$tg_id
    # Mongo DB Connection
    # DB <- connectMongo(Addr=User_DB_Host, DB="scconfig", port = User_DB_Port)
    DB <- connectMongo(Addr=User_DB_Host, DB="tgconfig", port = User_DB_Port)
    
    # get Service Data from DB-
    query <- mongo.bson.buffer.create()
    mongo.bson.buffer.append(query, "tg_id", tg_id)
    query <- mongo.bson.from.buffer(query)
    fields <- mongo.bson.buffer.create()
    mongo.bson.buffer.append(fields, "service", 1)
    fields <- mongo.bson.from.buffer(fields)
    cursor <- mongo.find(mongo = DB, ns = paste(attr(DB, "db"), tg_id, sep = "."), query=query, fields =fields)
  
    # Service list 
    service <- list()
    if(mongo.cursor.next(cursor)){
      res <- mongo.cursor.value(cursor)
      res <- mongo.bson.to.list(res)     
      service[[1]] <- res
      while(mongo.cursor.next(cursor)){
        res <- mongo.cursor.value(cursor)
        service[[length(service)+1]] <- res
      }
    }
    
    
    list <- ls(envir=.GlobalEnv)
    
    if(length(service) == 0)
      stop("Not Maching Service")
    
    log <- list()
    log$service <- service
    log$LOG <- "service"
    log$TIME <- Sys.time()
    insertHistory(input$tg_id, log)
    
    for(servicedata in service) {
      
      if(!is.integer0(grep(x=nodelist[[1]], pattern="[:]"))) {
        rs <- RS.connect( host=unlist(strsplit(unlist(nodelist), split=":"))[1],
                          port=unlist(strsplit(unlist(nodelist), split=":"))[2] )
      }else{
        rs <- RS.connect( host=nodelist[[1]] )      
      }
      
      RS.eval(rs, require(CEMS))
      RS.eval(rs, CEMS::cems.init())
      
      for(name in list) {
        RS.assign(rs, name, get(name))
      }
      RS.assign(rs, "json_str", json_str)
      RS.assign(rs, "Service", servicedata)
      RS.eval(rs, x=cems.startRSlave(injson=json_str, Service=Service), wait=FALSE)
      
      RS.close(rs)
    }
  }
