# Spring Boot Demo 應用程式 - RHEL 部署指南

## 專案說明

這是一個簡單的 Spring Boot 應用程式，設計用於 Instana 監控測試。應用程式會隨機產生不同的 HTTP 狀態碼和異常，讓 Instana 能夠監控到各種錯誤情況。

### 功能特性

- **隨機錯誤產生**：
  - 50% 機率回傳 HTTP 200（正常）
  - 20% 機率拋出異常（RuntimeException 或 IllegalStateException）
  - 30% 機率回傳錯誤狀態碼（400, 500, 503）

- **Instana 監控整合**：
  - 自動被 Instana Agent 偵測
  - 追蹤所有 HTTP 請求
  - 記錄異常和錯誤
  - 提供效能指標

## 快速開始

### 📋 檔案清單

部署需要以下檔案：

1. **應用程式**
   - `target/spancer_spring_demo-0.0.1-SNAPSHOT.jar` - 主程式

2. **部署腳本**
   - `setup_java.sh` - Java 17 安裝腳本
   - `start_app.sh` - 應用程式啟動腳本
   - `stop_app.sh` - 應用程式停止腳本
   - `test_api.sh` - API 測試腳本（20 次請求）

3. **部署文件**
   - `COPY_PASTE_COMMANDS.txt` - **最重要！完整的複製貼上指令**
   - `DEPLOY_COMMANDS.md` - 詳細部署步驟
   - `QUICK_DEPLOY.sh` - 快速部署腳本

## 🚀 部署步驟

### 方法一：使用 COPY_PASTE_COMMANDS.txt（推薦）

1. 開啟 [`COPY_PASTE_COMMANDS.txt`](COPY_PASTE_COMMANDS.txt:1)
2. 按照檔案中的步驟，依序複製貼上指令即可

### 方法二：手動執行

#### 步驟 1：上傳檔案（在本地機器）

```bash
scp -i ~/Downloads/ssh_private_key.pem -P 2223 target/spancer_spring_demo-0.0.1-SNAPSHOT.jar U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 test_api.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 setup_java.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 start_app.sh U7YBP7Q@165.192.138.173:./spring_demo/
scp -i ~/Downloads/ssh_private_key.pem -P 2223 stop_app.sh U7YBP7Q@165.192.138.173:./spring_demo/
```

#### 步驟 2：SSH 登入

```bash
ssh -i ~/Downloads/ssh_private_key.pem -p 2223 U7YBP7Q@165.192.138.173
```

#### 步驟 3：安裝與啟動（在 RHEL 伺服器）

```bash
# 建立目錄並設定權限
mkdir -p ~/spring_demo && cd ~/spring_demo
chmod +x setup_java.sh start_app.sh stop_app.sh test_api.sh

# 安裝 Java 17
./setup_java.sh
source ~/.bashrc

# 驗證 Java
java -version

# 啟動應用程式
./start_app.sh

# 等待啟動
sleep 10

# 測試
curl http://localhost:8080/

# 執行完整測試
./test_api.sh
```

## 📊 測試結果範例

執行 `./test_api.sh` 後，你會看到類似以下的輸出：

```
--- 請求 #1 ---
503 Service Unavailable - Request #1
HTTP Status: 503

--- 請求 #2 ---
Greetings from Spring Boot! Spencer Hsieh - Request #2
HTTP Status: 200

--- 請求 #3 ---
500 Internal Server Error: 隨機運行時異常 - Request #3
HTTP Status: 500
```

## 🔍 Instana 監控

應用程式啟動後，Instana Agent 會自動偵測並開始監控。

### 在 Instana UI 中可以看到：

✅ **應用程式實例**
- 應用程式名稱：spancer_spring_demo
- 運行在 port 8080

✅ **HTTP 請求追蹤**
- 所有 GET / 請求
- 請求時間和回應時間

✅ **錯誤監控**
- HTTP 400 Bad Request
- HTTP 500 Internal Server Error
- HTTP 503 Service Unavailable

✅ **異常追蹤**
- RuntimeException
- IllegalStateException

✅ **效能指標**
- 回應時間
- 吞吐量
- 錯誤率

## 🛠️ 常用指令

### 應用程式管理

```bash
# 啟動
cd ~/spring_demo && ./start_app.sh

# 停止
cd ~/spring_demo && ./stop_app.sh

# 重新啟動
cd ~/spring_demo && ./stop_app.sh && sleep 2 && ./start_app.sh

# 查看狀態
ps aux | grep spancer_spring_demo
```

### 測試與監控

```bash
# 單次測試
curl http://localhost:8080/

# 完整測試（20 次）
cd ~/spring_demo && ./test_api.sh

# 查看日誌
tail -f ~/spring_demo/logs/app.log

# 查看最新 50 行日誌
tail -50 ~/spring_demo/logs/app.log
```

### 系統檢查

```bash
# 檢查 Java 版本
java -version

# 檢查 port 8080
netstat -tlnp | grep 8080

# 檢查 Instana Agent（如果有權限）
sudo systemctl status instana-agent
```

## 📁 專案結構

```
spancer_spring_demo/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/spancer_spring_demo/
│       │       ├── SpancerSpringDemoApplication.java
│       │       ├── HelloController.java          # 主要 API 控制器
│       │       └── GlobalExceptionHandler.java   # 異常處理器
│       └── resources/
│           └── application.properties            # 應用程式設定
├── target/
│   └── spancer_spring_demo-0.0.1-SNAPSHOT.jar   # 編譯後的 JAR
├── setup_java.sh                                 # Java 安裝腳本
├── start_app.sh                                  # 啟動腳本
├── stop_app.sh                                   # 停止腳本
├── test_api.sh                                   # 測試腳本
└── COPY_PASTE_COMMANDS.txt                       # 部署指令集
```

## 🔧 故障排除

### Java 版本問題

```bash
# 重新載入環境變數
source ~/.bashrc

# 確認 Java 版本
java -version
```

### Port 被佔用

```bash
# 查看誰在使用 port 8080
sudo lsof -i :8080

# 停止舊的應用程式
cd ~/spring_demo && ./stop_app.sh
```

### 應用程式無法啟動

```bash
# 查看完整日誌
cat ~/spring_demo/logs/app.log

# 手動啟動查看錯誤
cd ~/spring_demo
java -jar spancer_spring_demo-0.0.1-SNAPSHOT.jar
```

## 📝 技術規格

- **Java 版本**：17
- **Spring Boot 版本**：3.4.0
- **Port**：8080
- **框架**：Spring Boot Web, Spring Boot Actuator
- **建置工具**：Maven

## 👤 作者

Spencer Hsieh

## 📄 授權

此專案僅供測試和學習使用。