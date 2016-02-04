cems.publishMessage <-
function(json_str) {
    checkpkg("rJava")
    ip <- MQTT_Server_Host
    port <- MQTT_Server_Port
    key <- Key
    JSON <- fromJSON(json_str)
    
    if(JSON$type == "act") {
      topic <- paste(key, JSON$type, input$tg_id, sep="/")
      msg <- json_str
    }
    else if(JSON$type == "push") {
      topic <- paste(key, JSON$type, JSON$id, sep="/")
      msg <- JSON$message
    }
    
    .jinit("./MQTTPublisher.jar")
    mqtt <- .jnew("mqtt/MqttSend")
    
    mqtt$SEND(ip, port, topic, msg)  
  }
