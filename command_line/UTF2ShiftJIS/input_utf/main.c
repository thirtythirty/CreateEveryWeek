// 14418 坂田和也
#include <GLUT/glut.h>
#include <stdio.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#define WINDOW_WIDTH 320
#define WINDOW_HEIGHT 240
#define CLOCK_RADIUS 110

void Display(void);
void Reshape(int, int);
void DrowClockNeedle(int, int, int, int, int);
void DrowBackground(int,int);
void DrowClockFrame(int, int);
void PrintTime(int, int, int, int, int);
void Timer(int);

int main(int argc, char **argv)
{
    //  一般的な準備
    glutInit(&argc, argv);
    glutInitWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT);
    glutCreateWindow("clock");
    glutDisplayFunc(Display);
    glutReshapeFunc(Reshape);
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
    glClearColor(0.0, 0.0, 1.0, 1.0);

    // タイマー関数を設定
    glutTimerFunc(1000, Timer, 0);
    //  イベントループ突入
    glutMainLoop();

    return(0);
}

// 描画処理
void Display(void)
{
    glClear(GL_COLOR_BUFFER_BIT);

    // 画面サイズ取得
    int window_w,window_h;
    window_w = glutGet(GLUT_WINDOW_WIDTH);
    window_h = glutGet(GLUT_WINDOW_HEIGHT);

    // 背景描画
    DrowBackground(window_w, window_h);
    // 時計の枠の描画
    DrowClockFrame(window_w/2, window_h/2);

    // システム時間の取得
    time_t tt;
    struct tm *ts;
    time(&tt);
    ts = localtime(&tt);

    // 時計の針の描画
    DrowClockNeedle(window_w/2, window_h/2, ts->tm_hour, ts->tm_min, ts->tm_sec);
    // 時間を数字で描画
    PrintTime(window_w/2+50, window_h, ts->tm_hour, ts->tm_min, ts->tm_sec);

    glFlush(); // 蓄積した命令を直ちに実行せよ
    glutSwapBuffers(); // ダブルバッファリング対応  蓄積した命令を直ちに実行せよ
}

// 画面サイズが変更された際の処理
void Reshape(int w, int h){
    glViewport(0, 0, w, h);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluOrtho2D(0, w, 0, h);
    glScaled(1, -1, 1);
    glTranslated(0, -h, 0);
    // 画面サイズを固定もどす
    glutReshapeWindow(WINDOW_WIDTH, WINDOW_HEIGHT);
}

// タイマー関数 500msごとに描画を更新し、針を進めさせる
void Timer(int value) {
    glutPostRedisplay(); // 描画を更新する(Display関数が呼び出される)
    glutTimerFunc(500, Timer, 0);
}

// 背景描画
void DrowBackground(int w,int h){
    glBegin(GL_QUADS);
    glColor3ub(0,0,0);
    glVertex2i(0, 0);
    glVertex2i(0, h);

    glVertex2i(w, h);
    glVertex2i(w, 0);
    glEnd();
}

// 時計の枠の描画
void DrowClockFrame(int w, int h){
    float r;
    glBegin(GL_LINES);
      glLineWidth(5.0);
      glColor3ub(255,255,255);
      for(r = 0; r < 2*M_PI; r += M_PI/6){
        glVertex2i(w + sin(r)*CLOCK_RADIUS, h + cos(r)*CLOCK_RADIUS);
        glVertex2i(w + sin(r)*(CLOCK_RADIUS - 10), h + cos(r)*(CLOCK_RADIUS-10));
      }
    glEnd();

    glBegin(GL_LINES);
      glLineWidth(5.0);
      glColor3ub(255,255,255);
      for(r = 0; r < 2*M_PI; r += M_PI/30){
        glVertex2i(w + sin(r)*CLOCK_RADIUS, h + cos(r)*CLOCK_RADIUS);
        glVertex2i(w + sin(r)*(CLOCK_RADIUS - 3), h + cos(r)*(CLOCK_RADIUS-3));
      }
    glEnd();
}

// 時計の針の描画
void DrowClockNeedle(int x_c, int y_c, int h, int m, int s){
    float th_s = 2*M_PI*s/60;
    int l_s = 100;
    float x_s = x_c + l_s * sin(th_s);
    float y_s = y_c - l_s * cos(th_s);

    float th_m = 2*M_PI*(60*m + s)/3600;
    int l_m = 80;
    float x_m = x_c + l_m * sin(th_m);
    float y_m = y_c - l_m * cos(th_m);

    float th_h = 2*M_PI*(3600*h + 60*m + s)/43200;
    int l_h = 60;
    float x_h = x_c + l_h * sin(th_h);
    float y_h = y_c - l_h * cos(th_h);

    // hours
    glBegin(GL_QUADS);
    glLineWidth(5.0);
    glColor3ub(255,255,255);
    glVertex2i(x_c, y_c);
    glVertex2i(x_c + (l_h * 0.2) * sin(th_h - M_PI/6), y_c - (l_h * 0.2) * cos(th_h - M_PI/6));
    glVertex2i(x_h, y_h);
    glVertex2i(x_c + (l_h * 0.2) * sin(th_h + M_PI/6), y_c - (l_h * 0.2) * cos(th_h + M_PI/6));
    glEnd();

    // min
    glBegin(GL_QUADS);
    glLineWidth(5.0);
    glColor3ub(100,100,255);
    glVertex2i(x_c, y_c);
    glVertex2i(x_c + (l_m * 0.2) * sin(th_m - M_PI/12), y_c - (l_m * 0.2) * cos(th_m - M_PI/12));
    glVertex2i(x_m, y_m);
    glVertex2i(x_c + (l_m * 0.2) * sin(th_m + M_PI/12), y_c - (l_m * 0.2) * cos(th_m + M_PI/12));
    glEnd();

    // sec
    glBegin(GL_QUADS);
    glLineWidth(5.0);
    glColor3ub(255,100,100);
    glVertex2i(x_c, y_c);
    glVertex2i(x_c + (l_s * 0.2) * sin(th_s - M_PI/18), y_c - (l_s * 0.2) * cos(th_s - M_PI/18));
    glVertex2i(x_s, y_s);
    glVertex2i(x_c + (l_s * 0.2) * sin(th_s + M_PI/18), y_c - (l_s * 0.2) * cos(th_s + M_PI/18));
    glEnd();
}

// 時間を数字で描画
void PrintTime(int x, int y, int h, int m, int s) {
    glRasterPos2i(x,y);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + h/10);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + h%10);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, ':');
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + m/10);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + m%10);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, ':');
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + s/10);
    glutBitmapCharacter(GLUT_BITMAP_8_BY_13, '0' + s%10);
}