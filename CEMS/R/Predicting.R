Predicting <-
function(x, df) {
    #   Debugging(x, df, text="Method Predicting(x, df): ")
    
    value <- as.numeric(x)
    df <- df
    m <- arima(df)
    
    predictvalue <- as.numeric(predict(m)$pred)
    publicvalue <- df[nrow(df),]
    
    list <- list()
    
    print(paste("Public:", publicvalue, "Predicting:", predictvalue, sep = " "))
    if(max(value, predictvalue, publicvalue) == value) {
      result <- 1
    }
    else if(min(value, predictvalue, publicvalue) == value) {
      result <- 3
    }
    else {
      result <- 2
    }
    
    if(publicvalue - predictvalue < 0){
      list <- list(result=result)
    }
    else {
      list <- list(result=result+3)
    }
    
    return(list)
  }
