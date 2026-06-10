# 完整部署指令集 - 可直接複製貼上

## 步驟 1: 在本地機器上傳所有檔案到 RHEL 伺服器

```bash
# 上傳應用程式 JAR 檔
scp -i ~/Downloads/ssh_private_key.pem -P 2223 target/spancer_spring_demo-0.0.1-SNAPSHOT.jar U7YBP7Q@165.192.138.173:./spring_demo/

# 上傳測試腳本
scp -i ~/Downloads/ssh_private_key.pem -P 2223 test_api.sh U7YBP7Q@165.192.138.173:./spring_demo/

# 上傳 Java 安裝腳本
scp -i ~/Downloads/ssh_private_key.pem -P 2223 setup_java.sh U7YBP7Q@165.192.138.173:./spring_demo/

# 上傳啟動腳本
scp -i ~/Downloads/ssh_private_key.pem -P 2223 start_app.sh U7YBP7Q@165.192.138.173:./spring_demo/

# 上傳停止腳本
scp -i ~/Downloads/ssh_private_key.pem -P 2223 stop_app.sh U7YBP7Q@165.192.138.173:./spring_demo/
```

## 步驟 2: SSH 登入到 RHEL 伺服器

```bash
ssh -i ~/Downloads/ssh_private_key.pem -p 2223 U7YBP7Q@165.192.138.173
```

## 步驟 3: 在 RHEL 伺服器上執行以下指令

### 3.1 建立目錄並設定權限
```bash
mkdir -p ~/spring_demo && cd ~/spring_demo && chmod +x setup_java.sh start_app.sh stop_app.sh test_api.sh
```

### 3.2 安裝 Java 17
```bash
./setup_java.sh
```

### 3.3 重新載入環境變數
```bash
source ~/.bashrc
```

### 3.4 驗證 Java 安裝
```bash
java -version
```

### 3.5 啟動應用程式
```bash
./start_app.sh
```

### 3.6 等待應用程式啟動（約 5-10 秒）
```bash
sleep 10
```

### 3.7 測試應用程式
```bash
curl http://localhost:8080/
```

### 3.8 執行完整測試（20 次請求）
```bash
./test_api.sh
```

### 3.9 查看應用程式日誌
```bash
tail -f ~/spring_demo/logs/app.log
```
（按 Ctrl+C 退出日誌查看）

### 3.10 停止應用程式（需要時）
```bash
./stop_app.sh
```

## 常用指令

### 查看應用程式是否運行
```bash
ps aux | grep spancer_spring_demo
```

### 查看 port 8080 使用狀況
```bash
netstat -tlnp | grep 8080
```

### 重新啟動應用程式
```bash
./stop_app.sh && sleep 2 && ./start_app.sh
```

### 查看最新 50 行日誌
```bash
tail -50 ~/spring_demo/logs/app.log
```

### 即時監控日誌
```bash
tail -f ~/spring_demo/logs/app.log
```

## 一鍵部署腳本（在伺服器上執行）

如果需要快速重新部署，可以執行：

```bash
cd ~/spring_demo && ./stop_app.sh ; sleep 2 ; ./start_app.sh && sleep 10 && curl http://localhost:8080/
```

## 驗證 Instana 監控

應用程式啟動後，Instana Agent 會自動偵測並監控這個 Java 應用程式。

在 Instana UI 中應該能看到：
- 新的 Java 應用程式實例
- HTTP 請求追蹤
- 隨機產生的錯誤（400, 500, 503 狀態碼）
- 異常追蹤（RuntimeException, IllegalStateException）
- 效能指標

## 故障排除

### 如果 Java 版本不正確
```bash
source ~/.bashrc && java -version
```

### 如果 port 8080 被佔用
```bash
# 查看誰在使用
sudo lsof -i :8080

# 或修改 port（需要重新編譯）
```

### 如果應用程式無法啟動
```bash
# 查看完整日誌
cat ~/spring_demo/logs/app.log

# 手動啟動查看錯誤
cd ~/spring_demo && java -jar spancer_spring_demo-0.0.1-SNAPSHOT.jar