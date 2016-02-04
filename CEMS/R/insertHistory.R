insertHistory <-
function(type, list) {
    mongo <- connectMongo(Addr="127.0.0.1", DB="history", port=50000)
    list$TYPE <- type
    list$TIME <- as.character(Sys.time())
    
    ns <- paste(attr(mongo, "db"), toupper(list$TYPE), sep=".")
    mongo.insert(mongo, ns, mongo.bson.from.list(list))
    destroyMongo(mongo)
  }
