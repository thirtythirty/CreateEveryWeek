float light_pre = 0;
#define BEAT 300   // 音の長さを指定
#define PINNO 11   // 圧電スピーカを接続したピン番号
#define BUF_NUM 100
int sensor_values[BUF_NUM];
int count_for_senser_values;

void setup() {
  // put your setup code here, to run once:
//  pinMode(2,INPUT) ;    //スイッチに接続ピンをデジタル入力に設定
//  pinMode(4,INPUT) ;
//  pinMode(6,INPUT) ;

  pinMode(13,OUTPUT) ;  //ＬＥＤに接続ピンをデジタル出力に設定
  Serial.begin(9600);

  count_for_senser_values = 0;
  int i;
  for(i = 0; i < BUF_NUM; i++){
    sensor_values[i] = 0;
  }
}

void loop() {
  float R1=10000.0;
  float V=5.0;
 
  float light_senser;
  light_senser=analogRead(0);

  int sum = 0;
  int i;
  for(i = 0; i < BUF_NUM; i++){
    sum += sensor_values[i];
  }
  float average = sum/(float)BUF_NUM;
  
  if((float)light_senser > (average+3)){
    float light_diff = light_pre - light_senser;
//    if(light_diff < -50){
      tone(PINNO,262,BEAT) ;  // ド
//    }
    digitalWrite(13,HIGH);
  } else {
    digitalWrite(13,LOW);
  }
  light_pre = light_senser;
  // buf value
  sensor_values[count_for_senser_values%BUF_NUM] = light_senser;
  if(count_for_senser_values >= 10000){
    count_for_senser_values = 0;
  }
  count_for_senser_values+=1;
  Serial.print(light_senser);
  Serial.print("\t");
  Serial.print(average);
  Serial.println();
}
