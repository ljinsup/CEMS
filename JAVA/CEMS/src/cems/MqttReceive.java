package cems;

import java.util.Random;

import org.eclipse.paho.client.mqttv3.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class MqttReceive {
	protected static String HOST = Setting.readFile("config", "MQTT_Host");
	protected static String PORT = Setting.readFile("config", "MQTT_Port");
	protected static String key = null;
	
	protected static String clientID = MqttClient.generateClientId();
	protected static MqttClient mClient;
	static RConnect rc = new RConnect();
	static JSONParser parser=new JSONParser();
	/* Testing Field */
	
	public static void main(String[] args) {
		MQTTConnect(HOST, PORT);
//		Mongoconnect.ReceiveKEY();
		Random random = new Random();
		
		
		key = mongoConnect.receiveKey();
		
		while(key==null){
			key = mongoConnect.receiveKey();
			
			try {
				Thread.sleep(random.nextInt(10) * 1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				
			}
			
		}
		Receive(key);
	}

	/************************************************** Connect MQTT Server **************************************************/
	private static void MQTTConnect(final String HOST, final String PORT) {
		try {
			mClient = new MqttClient("tcp://" + HOST + ":" + PORT, clientID);
			mClient.connect();
			
			mClient.setCallback(new MqttCallback() {
				public void deliveryComplete(IMqttDeliveryToken arg0) {
				}
				public void messageArrived(String topic, final MqttMessage rMessage)
						throws Exception {
					
					String str = rMessage.toString();
					JSONObject doc = (JSONObject) parser.parse(str); 
					System.out.println(doc.get("type").toString());
					
					 if (doc.get("type").toString().equals("sensordata")) {
						RConnect.start(str);
					}
				}
				public void connectionLost(Throwable arg0) {
					MQTTConnect(HOST, PORT);
				}
			});
		} catch (MqttException e) {
			System.out.println("MQTTConnect() Error");
		}
	}

	/************************************************** Subscribe **************************************************/
	private static void Receive(String KEY) {
		try {
			mClient.subscribe(KEY + "/TGdata");
			System.out.println(KEY + "/TGdata");
		} catch (MqttException e2) {
			System.out.println("MQTT Subscribe Error");
		}
	}
	
}
