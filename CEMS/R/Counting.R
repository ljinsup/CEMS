Counting <-
function(x, df) {
    #   Debugging(x, df, text="Method Counting(x, df): ")  
    
    data <- subset(x=df, select=names(x))
    
    data <- na.omit(data)
    
    x <- DataForming(as.data.frame(x))
    data <- DataForming(as.data.frame(data))
    
    data <- count(data)
    per <- data$freq/sum(data$freq)*100
    names(per) <- "per"
    data$per <- per
    
    for(i in 1:nrow(data)) {
      if(is.include(x, data[i, 1:length(x)])) {
        return(list(rate=data[i, "per"]))
      }
      if(i == nrow(data))
        stop("No data")
    }
  }
