#include <Wire.h>
#include <SPI.h>
#include <SD.h>

File data;
const int chunk = 30;
byte buffer[chunk];
const int SLAVE_ADDRESS = 8;
const int traffic = 2;
int r;

//bool testOK = false;

void setup() {
  Wire.begin();
  pinMode(10, OUTPUT);
  pinMode(traffic, INPUT);

  SD.begin(10);
  //data = SD.open("VIDEO.bin");
  data = SD.open("boing.bin");
}

void loop() {
  //if (testOK) return;
  r = digitalRead(traffic);
  if (r == HIGH) return;

  if (data && data.available()) {
    byte frameBuffer[720];

    int byteRead = data.read(frameBuffer, 720);

    if (byteRead > 0) {
      for (int i = 0; i < byteRead; i += chunk) {
        int size = min(chunk, byteRead - i);



        Wire.beginTransmission(SLAVE_ADDRESS);
        Wire.write(&frameBuffer[i], size);
        Wire.endTransmission();
      }

      //testOK = true;
    }
  } else {
    if (data) {
      data.seek(0);
    }
  }
}

/*
#include <SPI.h>
#include <SD.h>

File data;
const int chunk = 64;
byte buffer[chunk];

void setup() {
  Serial.begin(115200);

  pinMode(10, OUTPUT);

  //while(!Serial);

  SD.begin(10);
  data = SD.open("VIDEO.bin");
  //data = SD.open("test.bin");
}

void loop() {
  if(data && data.available()){
    int bytesRead = data.read(buffer, chunk);
    for(int i = 0; i < bytesRead; i++){
      byte byteAct = buffer[i];
      //Serial.print(byteAct);
      //Serial.print(",");
      
      for(int b = 7; b >= 0; b--){
        int unBit = bitRead(byteAct, b);
        Serial.write(unBit);
      }
    }
  } else {
    if(data){
      data.seek(0);
    }
  }
}
*/