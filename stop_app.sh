#!/bin/bash

APP_DIR="$HOME/spring_demo"
PID_FILE="$APP_DIR/app.pid"

if [ ! -f $PID_FILE ]; then
    echo "找不到 PID 檔案，應用程式可能沒有運行"
    exit 1
fi

PID=$(cat $PID_FILE)

if ps -p $PID > /dev/null 2>&1; then
    echo "停止應用程式 (PID: $PID)..."
    kill $PID
    
    # 等待程序結束
    for i in {1..10}; do
        if ! ps -p $PID > /dev/null 2>&1; then
            echo "應用程式已成功停止"
            rm -f $PID_FILE
            exit 0
        fi
        sleep 1
    done
    
    # 如果還沒停止，強制終止
    echo "強制終止應用程式..."
    kill -9 $PID
    rm -f $PID_FILE
    echo "應用程式已強制停止"
else
    echo "應用程式沒有運行 (PID: $PID)"
    rm -f $PID_FILE
fi

# Made with Bob
