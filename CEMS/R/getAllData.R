getAllData <-
function(mongo, collection, sort=NULL){
    checkpkg("plyr")
    #   res.frame <- list()
    
    res.frame <- data.frame()
    if(mongo.is.connected(mongo)){
      if(!is.null(sort)){
        cursor <- mongo.find(mongo=mongo,
                             ns=paste(attr(mongo, "db"), as.character(collection), sep="."),
                             query=mongo.bson.empty(),
                             sort=mongo.bson.from.JSON(paste("{\"", sort, "\" : 1}", sep="")),
                             fields='{"_id":0}')
      } else {
        cursor <- mongo.find(mongo=mongo,
                             ns=paste(attr(mongo, "db"), as.character(collection), sep="."),
                             query=mongo.bson.empty(),
                             fields='{"_id":0}')
      }
      
      if(mongo.cursor.next(cursor)){
        res <- mongo.cursor.value(cursor)
        res <- mongo.bson.to.list(res)     
        res.frame <- as.data.frame(res)
        #         res.frame <- rbind(unlist(res))
        while(mongo.cursor.next(cursor)){
          res <- mongo.cursor.value(cursor)
          res <- mongo.bson.to.list(res)
          res <- as.data.frame(res)
          res.frame <- rbind.fill(res.frame, res)
        }
      } else {
        stop("No Data")
      }
    }
    if(length(res.frame) == 0)
      return(data.frame())
    else
      return(res.frame)
  }
