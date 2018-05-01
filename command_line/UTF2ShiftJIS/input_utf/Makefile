#
#  Makefile
#

#  最終目的ファイル
TARGET = j14418.exe

SRCS = main.c

# オブジェクトファイル(*.oの一覧)
OBJS = ${SRCS:.c=.o}

# ヘッダファイルの一覧(今は何もなし)
HEADERS =

# コンパイラ・リンカの指定
CC = gcc
CCFLAGS = -Wall
LD = gcc
LDFLAGS =
LIBS = -lm -lglut32 -lglu32 -lopengl32

# OBJSからTARGETを作る方法
$(TARGET) : $(OBJS) $(ICON_OBJ)
	$(LD) $(OBJS) $(ICON_OBJ) $(LDFLAGS) -o $(TARGET) $(LIBS)

# *.cから*.oを作る方法
.c.o :
	$(CC) $(CCFLAGS) -c $<

# *.oはHEADERSとMakefileに依存(これらが書き換わった時にも*.oを再構築)
$(OBJS) : $(HEADERS) Makefile

$(ICON_OBJ) :
	windres -i icon.rc -o icon.ico

# make cleanとした時に実行されるコマンド
clean :
	rm -f $(TARGET) $(OBJS) core *-