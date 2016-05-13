connectMongo <-
function(Addr="127.0.0.1", DB="test", port=28017){
    checkpkg("rmongodb")
    return(mongo.create(host=paste(Addr, ":", port, sep=""), db=DB))
  }
