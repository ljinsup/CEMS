Comparing <-
function(x, df) {
    #   Debugging(x, df, text="Method Compare(x, df): ")
    MEAN <- apply(df, 2, mean)
    MAX <- apply(df, 2, max)
    MIN <- apply(df, 2, min)
    
    if(x > MEAN) {
      res <- list(rate=(x-MEAN)/(MAX-MEAN)*100)
    }else if(x < MEAN){
      res <- list(rate=(MEAN-x)/(MEAN-MIN)*-100)
    }else{
      res <- list(rate= 0)
    }
    return(res)
  }
