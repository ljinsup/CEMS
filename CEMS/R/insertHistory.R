insertHistory <-
function(type, list) {
    mongo <- connectMongo(Addr=User_DB_Host, DB="history", port=User_DB_Port)
    list$TYPE <- type
    list$TIME <- as.character(Sys.time())
    
    ns <- paste(attr(mongo, "db"), toupper(list$TYPE), sep=".")
    mongo.insert(mongo, ns, mongo.bson.from.list(list))
    destroyMongo(mongo)
  }
