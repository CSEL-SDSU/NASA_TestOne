#include <Servo.h>
#include <millisDelay.h>

Servo srv; //Initialize servo object
millisDelay ignitorDelay; //Delay to allow code to run while ignitor active

int servo = 9; //Arduino pins for servo and relay
int relay = 13;

int retract = 20; // Sevo positions
int extend = 95;

void setup() 
{
  srv.attach(servo); // Set pin for servo and home motor
  srv.write(retract);

  pinMode(relay, OUTPUT); //Open relay circuit arduino pin and set as output
  digitalWrite(relay, 0); 
}

void loop() 
{
  if (Serial.available() > 0) { //Checks for incoming data
    
    String ignInput = Serial.readStringUntil('\n'); //Reads ignition time from GUI
    long ignTime = ignInput.toInt();
    
    srv.write(extend); //Rotate servo to sample and close ignition circuit
    digitalWrite(relay, 1);
    
    ignitorDelay.start(ignTime); //Ignition time set as delay duration

    if (Serial.available() > 0) {  //Ends ignitor delay when receive 0 from GUI
      String stopInput = Serial.readStringUntil('\n');
      long stopNum = stopInput.toInt();
      if (stopNum == 0) {
         ignitorDelay.finish();
      }
    }
  }

  if (ignitorDelay.remaining()==0){ //Rotate servo to home and open ignition circuit when ignitor delay ends
      digitalWrite(relay, 0); 
      srv.write(retract);
    }
}


