cems.startRMaster <-
function (json_str) {
    # 초기화
    cems.init()
    
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
    TG_DB <- connectMongo(Addr=User_DB_Host,
                          DB=User_DB_Name)
    
    # get Thin-gateway Data from DB-
    service <- mongo.get.values(mongo, paste(attr(TG_DB, "db"), tg_id, sep = "."), "service")
    
    # Service list 
    list <- ls(envir=.GlobalEnv)
    
    if(length(service) == 0)
      stop("Not Maching Service")
    
    log <- list()
    log$service <- service
    log$LOG <- "service"
#     insertHistory(input$tg_id, log)
    
    for(servicedata in service) {
      if(!is.integer0(grep(x=nodelist[[1]], pattern="[:]"))) {
        rs <- RS.connect( host=unlist(strsplit(unlist(nodelist), split=":"))[1],
                          port=unlist(strsplit(unlist(nodelist), split=":"))[2] )
      }else{
        rs <- RS.connect( host=nodelist[[1]] )      
      }
      
      RS.eval(rs, require(CEMS))
      RS.eval(rs, CEMS::.init())
      
      for(name in list) {
        RS.assign(rs, name, get(name))
      }
      RS.assign(rs, "json_str", json_str)
      RS.assign(rs, "Service", servicedata)
      RS.eval(rs, x=cems.startRSlave(injson=json_str, Service=servicedata), wait=FALSE)
      
      RS.close(rs)
    }
  }
