Debugging <-
function(..., text="") {
    for(l in list(...)){
      message(text)
      print(l)
      cat("\n-----------------------------------\n")
    }
  }
