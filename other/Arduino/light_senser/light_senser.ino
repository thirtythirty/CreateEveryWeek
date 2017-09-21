float light_pre = 0;
#define BEAT 300   // 音の長さを指定
#define PINNO 11   // 圧電スピーカを接続したピン番号

void setup() {
  // put your setup code here, to run once:
//  pinMode(2,INPUT) ;    //スイッチに接続ピンをデジタル入力に設定
//  pinMode(4,INPUT) ;
//  pinMode(6,INPUT) ;

  pinMode(13,OUTPUT) ;  //ＬＥＤに接続ピンをデジタル出力に設定
  Serial.begin(9600);
}

void loop() {
  float R1=10000.0;
  float V=5.0;
 
  float light_senser;
  light_senser=analogRead(0);

  
  
  if(light_senser > 100){
    float light_diff = light_pre - light_senser;
    if(light_diff < -50){
      tone(PINNO,262,BEAT) ;  // ド
    }
    digitalWrite(13,HIGH);
  } else {
    digitalWrite(13,LOW);
  }
  light_pre = light_senser;
  Serial.print(light_senser);
//  Serial.print("\t");
  Serial.println();
}
