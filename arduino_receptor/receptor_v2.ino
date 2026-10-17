#include <Wire.h>
#include <TVout.h>

const int SLAVE_ADDRESS = 8;
const int traffic = 2;

volatile int screenIndex = 0; 
bool isBottomHalf = false;

TVout TV;

void setup() {
  Wire.begin(SLAVE_ADDRESS);
  Wire.onReceive(receiveEvent);

  TV.begin(NTSC, 120, 96);

  pinMode(traffic, OUTPUT);
  digitalWrite(traffic, LOW);
}

void loop() {
  
}

void receiveEvent(int howMany) {
  while (Wire.available()) {
    byte incomingByte = Wire.read();

    if (screenIndex < 1440) {
      TV.screen[screenIndex] = incomingByte;
      screenIndex++;
    }

    if (screenIndex >= 1440) {
      digitalWrite(traffic, HIGH); 
      screenIndex = 0;  
      digitalWrite(traffic, LOW);  
    }
  }
}

/*
// buen intento
#include <Wire.h>
#include <TVout.h>

const int SLAVE_ADDRESS = 8;
const int traffic = 2;

byte data[720];
const int HALF_SIZE = 720;
bool isBottomHalf = false;

TVout TV;

volatile int indexData = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin(SLAVE_ADDRESS);
  Wire.onReceive(receiveEvent);

  TV.begin(NTSC, 120, 96);

  pinMode(traffic, OUTPUT);
  digitalWrite(traffic, LOW);
  Serial.print(1);
  TV.draw_line(0, 0, 119, 95, WHITE);
}

void loop() {
  if (indexData >= HALF_SIZE) {
    if (!isBottomHalf) {
      TV.clear_screen();
      for (int i = 0; i < HALF_SIZE; i++) {
        TV.screen[i] = data[i];
      }
      isBottomHalf = true;
    } else {
      for (int i = 0; i < HALF_SIZE; i++) {
        TV.screen[HALF_SIZE + i] = data[i];
      }
      isBottomHalf = false;
    }

    indexData = 0;           
    digitalWrite(traffic, LOW);   
  }
}

void receiveEvent(int howMany) {
  while (Wire.available() && indexData < HALF_SIZE) {
    data[indexData] = Wire.read();
    indexData++;
    Serial.println("paquete");
    
    if (indexData >= HALF_SIZE) {
      Serial.println("desenpacando");
      digitalWrite(traffic, HIGH);  
    }
  }
}
*/

/*
// funcional entrega y muestra de datos
#include <Wire.h>

const int SLAVE_ADDRESS = 8; 
const int traffic = 2;

byte data[720];

//bool itsReady = false;
volatile int indexData = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin(SLAVE_ADDRESS); 
  Wire.onReceive(receiveEvent);

  pinMode(traffic, OUTPUT);
  digitalWrite(traffic, LOW); 
}

void loop() {
  if (indexData >= 720){
    indexData = 0;
    //itsReady = false;
    
    for(int i = 0; i < 720; i++){
      Serial.write(data[i]);
    }

    digitalWrite(traffic, LOW);
  } 
}

void receiveEvent(int howMany) {
  while (Wire.available() && indexData < 720) {
    data[indexData] = Wire.read();
    indexData++;
    if (indexData >= 720) digitalWrite(traffic, HIGH);
  }
}
*/

/*
// FUNCIONAL base
#include <Wire.h>

const int SLAVE_ADDRESS = 8; 

void setup() {
  Serial.begin(115200);
  Wire.begin(SLAVE_ADDRESS); 
  Wire.onReceive(receiveEvent); 
}

void loop() {

}

void receiveEvent(int howMany) {
  while (Wire.available()) {
    byte takeIn = Wire.read();

    Serial.write(takeIn);
  }
}
*/

/*
#include <SoftwareSerial.h>
SoftwareSerial softSerial(2, 3);

void setup() {
  Serial.begin(115200);   
  nanoSerial.begin(115200);
}

void loop() {
  if (softSerial.available () > 0){
    byte takeIn = softSerial.read();

    Serial.print(takeIn);
    Serial.println(",");
  }
}
*/