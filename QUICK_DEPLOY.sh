#!/bin/bash

# ============================================
# 快速部署腳本 - 在本地機器執行
# ============================================

echo "=== 步驟 1: 上傳所有檔案到 RHEL 伺服器 ==="

scp -i ~/Downloads/ssh_private_key.pem -P 2223 target/spancer_spring_demo-0.0.1-SNAPSHOT.jar U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 test_api.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 setup_java.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 start_app.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 stop_app.sh U7YBP7Q@165.192.138.173:./spring_demo/

echo ""
echo "=== 檔案上傳完成！==="
echo ""
echo "=== 步驟 2: 請複製以下指令，SSH 登入伺服器後執行 ==="
echo ""
echo "ssh -i ~/Downloads/ssh_private_key.pem -p 2223 U7YBP7Q@165.192.138.173"
echo ""
echo "=== 步驟 3: 登入後，複製貼上以下完整指令區塊 ==="
echo ""
cat << 'EOF'

# 建立目錄並設定權限
mkdir -p ~/spring_demo && cd ~/spring_demo && chmod +x setup_java.sh start_app.sh stop_app.sh test_api.sh

# 安裝 Java 17
./setup_java.sh

# 重新載入環境變數
source ~/.bashrc

# 驗證 Java 版本
java -version

# 啟動應用程式
./start_app.sh

# 等待啟動
sleep 10

# 測試應用程式
curl http://localhost:8080/

# 執行完整測試（20 次請求）
./test_api.sh

# 查看日誌（按 Ctrl+C 退出）
tail -f ~/spring_demo/logs/app.log

EOF

# Made with Bob
