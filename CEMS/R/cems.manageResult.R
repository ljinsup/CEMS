cems.manageResult <-
function(Service, value, relationvalue) {
    #   Debugging(Service_id, value, relationvalue, text="ReceiveResult(Service_id, value, relationvalue): ")
  print("****************************************")
  print("*                                      *")
  print("*             Result Process           *")
  print("*                                      *")
  print("****************************************")  
  
  list <- list()
    print(paste("Result:", value, sep = " "))
    Resmnmt <- Service$resultmnmt
    print("::::::::::Result::::::::::")
    print(Resmnmt)
    
    
    if(exists("result", where=value)) {
      for(RES in Resmnmt){
        if(relationvalue == as.character(RES$relation) && is.include(value, RES$result)) {
          list <- append(list, list(RES))
        }
      }
    }  
    else if(exists("rate", where=value)) {
      for(RES in Resultmnmt){
        if(relationvalue == as.character(RES$relation) 
           && value$rate > as.numeric(unlist(strsplit(RES$rate, split=" "))[1]) 
           && value$rate <= as.numeric(unlist(strsplit(RES$rate, split=" "))[2])) {
          list <- append(list, list(RES))
        }
      }
    }
    print("::::::::::Processing::::::::::")
    print(list)
    if(length(list) == 0){
      cems.clear(Service$service_id)
      return
    }
    
    for(l in list){
      if(l$type =="act") {  
        print("****************************************")
        print("*           Actuator Control           *")
        print("****************************************")
        print("Action MQTT")
        cems.publishMessage(cems.createMessage(l))
      }
      else if(l$type == "next") {      
        print("Next Analysis")
        cems.continueAnalysis(injson="input", Service=Service, index=l$NO)
      }
    }
  }
