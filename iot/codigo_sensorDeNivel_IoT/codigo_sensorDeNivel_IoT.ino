


#include <ESP8266WiFi.h>
#include <PubSubClient.h>


//atualize SSID e senha WiFi
const char* ssid = "HackaTruckVisitantes";
const char* password = "";


//D4 only for Lolin board
#define LED_BUILTIN D4


//Atualize os valores de Org, device type, device id e token
#define ORG "xzjayz"
#define DEVICE_TYPE "alagamentoIoT"
#define DEVICE_ID "testeHackaTruck"
#define TOKEN "12345678"


//broker messagesight server
char server[] = ORG ".messaging.internetofthings.ibmcloud.com";
char topic[] = "iot-2/evt/status/fmt/json";
char authMethod[] = "use-token-auth";
char token[] = TOKEN;
char clientId[] = "d:" ORG ":" DEVICE_TYPE ":" DEVICE_ID;


float umidade = 0.0;
char umidadestr[6];


WiFiClient wifiClient;
PubSubClient client(server, 1883, NULL, wifiClient);


void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println("Iniciando...");
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);

  Serial.print("Conectando na rede WiFi ");
  Serial.print(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("[INFO] Conectado WiFi IP: ");
  Serial.println(WiFi.localIP());


  pinMode(LED_BUILTIN, OUTPUT);
}

int a1() {
  digitalWrite(4, HIGH);
  digitalWrite(5, LOW);
  return analogRead(0);
}
int a2() {
  digitalWrite(4, LOW);
  digitalWrite(5, HIGH);
  return analogRead(0);
} 

void loop() {


  if (!!!client.connected()) {
    Serial.print("Reconnecting client to ");
    Serial.println(server);
    while (!!!client.connect(clientId, authMethod, token)) {
      Serial.print(".");
      delay(500);
    }
    Serial.println();
  }

  float Valor1;
  float Valor2;

  Valor1 = (a1() > 500) ? 1.0 : 0.0;  
  delay(200);
  Valor2 = (a2() > 500) ? 1.0 : 0.0;
  delay(200);

  Serial.print("[Leitura alerta] ");
  Serial.println(Valor1);

  Serial.print("[Leitura alagamento] ");
  Serial.println(Valor2);

  // Conversao Floats para Strings
  char TempString[32];  //  array de character temporario
  char TempString2[32];

  // dtostrf( [Float variable] , [Minimum SizeBeforePoint] , [sizeAfterPoint] , [WhereToStoreIt] )
  dtostrf(Valor1, 2, 1, TempString);
  String valor1str = String(TempString);

  dtostrf(Valor2, 2, 1, TempString2);
  String valor2str = String(TempString2);


  // Prepara JSON para IOT Platform
  int length = 0;


  String payload = "{\"d\":{\"deviceID\":\"testeHackaTruck\", \"sensorAlerta\":\"" + valor1str + "\", \"sensorAlaga\":\"" + valor2str + "\"}}";    


  length = payload.length();
  Serial.print(F("\nData length"));
  Serial.println(length);


  Serial.print("Sending payload: ");
  Serial.println(payload);


  if (client.publish(topic, (char*)payload.c_str())) {
    Serial.println("Publish ok");
    digitalWrite(LED_BUILTIN, LOW);
    delay(500);
    digitalWrite(LED_BUILTIN, HIGH);
    delay(500);
  } else {
    Serial.println("Publish failed");
    Serial.println(client.state());
  }

  delay(10000);

}
