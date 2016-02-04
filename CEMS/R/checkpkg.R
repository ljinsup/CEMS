checkpkg <-
function(...){
    for(l in list(...))
    {
      if(!require(package=l, character.only=TRUE)) {
        install.packages(pkg=l, repos="http://cran.nexr.com/")
        if(!require(package=l, character.only=TRUE)) stop("Error Package Loading")
      }  
    }
  }
