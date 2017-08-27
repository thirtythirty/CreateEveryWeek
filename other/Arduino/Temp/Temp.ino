void setup() {
  // put your setup code here, to run once:
//  pinMode(2,INPUT) ;    //スイッチに接続ピンをデジタル入力に設定
//  pinMode(4,INPUT) ;
//  pinMode(6,INPUT) ;

  pinMode(13,OUTPUT) ;  //ＬＥＤに接続ピンをデジタル出力に設定
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
//  if (digitalRead(2) == HIGH) { //スイッチの状態を調べる
//    digitalWrite(13,HIGH) ;      //スイッチが押されているならLEDを点灯
//  } else {
//    digitalWrite(13,LOW) ;       //スイッチが押されていないならLEDを消灯
//  }

//  Serial.print(digitalRead(2));
//  Serial.print("\t");
//  Serial.print(digitalRead(4));
//  
//  Serial.print("\t");
//  Serial.print(digitalRead(6));
//  Serial.print("\t");
  float room_temp;
  float B=3435,T0=298.15,R0=10.0,R1=10.0,rr1,t;
  int n;
  n=analogRead(0);
  rr1=R1*n/(1024.0-n);
  t=1/(log(rr1/R0)/B+(1/T0));
  room_temp = t-273.15;

  float thermocouple_t = analogRead(2)/1024.0*5/0.0041107;

  float temp = room_temp + thermocouple_t;
  
  Serial.print(room_temp);
  Serial.print("\t");
  Serial.print(thermocouple_t);
  Serial.print("\t");
  Serial.print(temp);

  Serial.println();
}
