#!/bin/bash

APP_NAME="spancer_spring_demo-0.0.1-SNAPSHOT.jar"
APP_DIR="$HOME/spring_demo"
LOG_DIR="$APP_DIR/logs"
PID_FILE="$APP_DIR/app.pid"

# 建立 logs 目錄
mkdir -p $LOG_DIR

# 檢查是否已經在運行
if [ -f $PID_FILE ]; then
    PID=$(cat $PID_FILE)
    if ps -p $PID > /dev/null 2>&1; then
        echo "應用程式已經在運行中 (PID: $PID)"
        exit 1
    fi
fi

echo "啟動 Spring Boot 應用程式..."
cd $APP_DIR

nohup java -jar $APP_NAME > $LOG_DIR/app.log 2>&1 &
echo $! > $PID_FILE

echo "應用程式已啟動 (PID: $(cat $PID_FILE))"
echo "日誌檔案: $LOG_DIR/app.log"
echo "執行 'tail -f $LOG_DIR/app.log' 查看日誌"

# Made with Bob
