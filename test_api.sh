#!/bin/bash

echo "開始測試 API - 總共執行 20 次請求"
echo "=================================="
echo ""

for i in {1..20}
do
    echo "--- 請求 #$i ---"
    response=$(curl -s -w "\nHTTP Status: %{http_code}\n" http://localhost:8080/)
    echo "$response"
    echo ""
    sleep 0.5
done

echo "=================================="
echo "測試完成！"

# Made with Bob
