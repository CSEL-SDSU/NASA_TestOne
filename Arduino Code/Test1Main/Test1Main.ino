#include <Adafruit_ADS1X15.h> //ADC, servo, and non-blocking delay libraries (install through Arduino IDE manager if necessary)
#include <Servo.h>
#include <millisDelay.h>

Adafruit_ADS1115 ads1115;	// Construct an ads1115
Servo srv; //Initialize servo object
millisDelay ignitorDelay; //Delay to allow code to run while ignitor active

int servo = 9; //Arduino pins for servo and relay
int relay = 13;

void setup() 
{
  Serial.begin(9600); //Open serial port and I2C communication with ADC
  ads1115.begin();

  srv.attach(servo); // Set pin for servo and home motor
  srv.write(35);

  pinMode(relay, OUTPUT); //Open relay circuit arduino pin and set as output
  digitalWrite(relay, 0); 
}

void loop() 
{
  if (Serial.available() > 0) { //Checks for incoming data
    
    String ignInput = Serial.readStringUntil('\n'); //Reads ignition time from GUI
    long ignTime = ignInput.toInt();
    
    srv.write(115); //Rotate servo to sample and close ignition circuit
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
      srv.write(35);
    }

  ads1115.setGain(GAIN_TWO); //Set ADC gain
  Serial.println(ads1115.readADC_SingleEnded(0)); //Prints raw data to serial port to be read by GUI
}
