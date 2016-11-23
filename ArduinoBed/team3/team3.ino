#include <SoftwareSerial.h>
#include <Stepper.h>
#include <Wire.h> 

int sw1 = 2;//탁상
int sw2 = 3;//탁상
int sw3 = 4;//커튼
int sw4 = 5;//커튼
int sw5 = 6;//침대
int sw6 = 7;//침대

int a = 0;
int b = 0;
int c = 0;
int d = 0 ; // 커튼 회전 수 제한용

const int stepsPerRevolution = 200; // 스텝 모터 한바퀴 회전 
const int stepsPerRevolution1 = 1300; // 탁상 회전용
const int stepsPerRevolution2 = 250; // 침대 각도 조절용
const int curtainSpin = 10; // 커튼 최대 회전수 20=5바퀴
const int stepsPer = 0;   // 2048:한바퀴(360도), 1024:반바퀴(180도)...

SoftwareSerial BTSerial=SoftwareSerial(10,11);

Stepper myStepper1 (stepsPerRevolution1,52,48,50,46); // 탁상
Stepper myStepper2 (stepsPerRevolution,44,40,42,38); // 커튼, 512는 360도 회전하기 위해 필요한 스텝 수
Stepper myStepper3 (512,36,32,34,30); // 침대 각도
// 모터 드라이브에 연결된 핀 IN4, IN2, IN3, IN1

void setup() {

  BTSerial.begin(9600);
  Serial.begin(9600);
  myStepper1.setSpeed(14);
  myStepper2.setSpeed(20);
  myStepper3.setSpeed(14);
   
  pinMode(sw1,INPUT_PULLUP);
  pinMode(sw2,INPUT_PULLUP);
  pinMode(sw3,INPUT_PULLUP);
  pinMode(sw4,INPUT_PULLUP);
  pinMode(sw5,INPUT_PULLUP);
  pinMode(sw6,INPUT_PULLUP);
 
}

void loop() {

  myStepper1.step(stepsPer);
  myStepper2.step(stepsPer);
  myStepper3.step(stepsPer);
// 정지

// 침대 탁상 조절
  if(digitalRead(sw1) == LOW) {
    if (a==0)
    {
      myStepper1.step(-stepsPerRevolution1);
      myStepper1.step(stepsPer);
      a = a + 1;
    }
    Serial.println(a);
  }

  else if (digitalRead(sw2) == LOW) {
  // 시계 방향으로 회전
  if (a==1)
  {
    myStepper1.step(stepsPerRevolution1);
    myStepper1.step(stepsPer);
    a = a - 1;
  }
  Serial.println(a);
  }

//침대 커튼 조절

  if(digitalRead(sw3) == LOW) {
    if(d!=curtainSpin){
    for( int i =d ; i < curtainSpin ; i++){
      Serial.print(d);
      myStepper2.step(stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d+1;
      Serial.print(d);
    }
    }
  }

  else if (digitalRead(sw4) == LOW) {
    if(d>0){
    for( int i = d ; 0 < i ; i-- ){
      Serial.print(d);
      myStepper2.step(-stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d-1;
      Serial.print(d);
    }
    }  
  }


// 침대 테이블 조절
  if(digitalRead(sw5) == LOW) {
    if (c==0||c==1||c==2||c==3||c==4)
    {
      myStepper3.step(-stepsPerRevolution2);
      myStepper3.step(stepsPer);
      c = c + 1;
    }
    Serial.println(c);
    
  // 시계 반대 방향으로 한바퀴 회전

  }

  else if (digitalRead(sw6) == LOW) {
    if (c==1||c==2||c==3||c==4||c==5)
    {
      myStepper3.step(stepsPerRevolution2);
      myStepper3.step(stepsPer);
      c = c - 1;
      }
      Serial.println(c);
  }

  if(BTSerial.available())
  {
    char cmd = (char)BTSerial.read();
    if(cmd == '1'){
      if (c==0||c==1||c==2||c==3||c==4)
     {
      myStepper3.step(-stepsPerRevolution2);
      myStepper3.step(stepsPer);
      c = c + 1;
      Serial.println(c);
     }
    } else if(cmd == '2'){
      if (c==1||c==2||c==3||c==4||c==5)
    {
      myStepper3.step(stepsPerRevolution2);
      myStepper3.step(stepsPer);
      c = c - 1;
      Serial.println(c);
    }
    }
    if(cmd == '3') {
        if (a==0)
       {
         myStepper1.step(-stepsPerRevolution1);
         myStepper1.step(stepsPer);
         a = a + 1;
         Serial.println(a);
       }
    }else if(cmd == '4') {
       if (a==1)
      {
       myStepper1.step(stepsPerRevolution1);
       myStepper1.step(stepsPer);
       a = a - 1;
       Serial.println(a);
      }
    }
    if(cmd == '5') {
       if(d < curtainSpin ){ 
        Serial.print(d);
      myStepper2.step(stepsPerRevolution);
      myStepper2.step(stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d+2;
      Serial.print(d);
       }
    } else if(cmd == '0') {
      if( d > 0){
        Serial.print(d);
      myStepper2.step(-stepsPerRevolution);
      myStepper2.step(-stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d-2;
      Serial.print(d);
      }
    }else if(cmd=='6'){
    if(d!=curtainSpin){
    for( int i = d ; i <curtainSpin ; i++){
      myStepper2.step(stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d+1;
    }
    }
    }else if(cmd='0'){
    if(d>0){
    for( int i = d ; -1 < i ; i-- ){
      myStepper2.step(-stepsPerRevolution);
      myStepper2.step(stepsPer);
      d=d-1;
    }
    }    
    
    }
    }
         
  }                 
