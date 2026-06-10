# Spring Boot 測試示範專案

## 專案簡介

這是一個簡單的 Spring Boot 測試專案，主要用於 **Java 應用程式測試和監控工具的驗證**。專案實作了一個會隨機產生不同 HTTP 回應狀態的 REST API，非常適合用來測試：

- 應用程式效能監控 (APM) 工具
- 錯誤追蹤系統
- 日誌分析工具
- 負載測試工具
- API 監控系統

## 主要特色

### 🎲 隨機回應機制

專案的核心功能是 [`HelloController`](src/main/java/com/example/spancer_spring_demo/HelloController.java)，它會根據隨機數值產生不同的回應：

- **50% 機率**：正常回傳 `200 OK` 狀態
- **30% 機率**：回傳錯誤狀態碼
  - `400 Bad Request` (10%)
  - `500 Internal Server Error` (10%)
  - `503 Service Unavailable` (10%)
- **20% 機率**：拋出 Java 異常
  - `RuntimeException` (10%)
  - `IllegalStateException` (10%)

### 📊 請求計數器

每個請求都會被計數並記錄在 console log 中，方便追蹤和分析。

### 🔧 Spring Boot Actuator

整合了 Spring Boot Actuator，提供健康檢查和監控端點：
- `/actuator/health` - 健康檢查
- `/actuator/metrics` - 應用程式指標
- `/actuator/info` - 應用程式資訊

## 技術規格

- **Java 版本**：17
- **Spring Boot 版本**：3.4.0
- **預設埠號**：8080
- **建置工具**：Maven

## 快速開始

### 前置需求

- Java 17 或更高版本
- Maven 3.6+ (或使用專案內建的 `./mvnw`)

### 啟動應用程式

#### 方法 1：使用 Maven

```bash
./mvnw spring-boot:run
```

#### 方法 2：使用啟動腳本

```bash
./start_app.sh
```

#### 方法 3：建置並執行 JAR

```bash
./mvnw clean package
java -jar target/spancer_spring_demo-0.0.1-SNAPSHOT.jar
```

### 測試 API

應用程式啟動後，可以使用以下方式測試：

#### 單次請求

```bash
curl http://localhost:8080/
```

#### 批次測試（20 次請求）

```bash
./test_api.sh
```

這個腳本會連續發送 20 次請求，讓您觀察不同的回應狀態。

### 停止應用程式

```bash
./stop_app.sh
```

## 使用場景

### 1. APM 工具測試

測試應用程式效能監控工具（如 Instana、New Relic、Dynatrace）是否能正確：
- 追蹤請求
- 捕捉異常
- 記錄錯誤狀態碼
- 顯示效能指標

### 2. 錯誤處理驗證

驗證全域異常處理器 [`GlobalExceptionHandler`](src/main/java/com/example/spancer_spring_demo/GlobalExceptionHandler.java) 是否正確處理不同類型的異常。

### 3. 日誌系統測試

測試日誌收集系統是否能正確收集和分析：
- 正常請求日誌
- 錯誤日誌
- 異常堆疊追蹤

### 4. 負載測試

使用此專案作為負載測試的目標，觀察系統在不同錯誤率下的表現。

### 5. 監控告警測試

測試監控系統的告警機制是否能在錯誤率超過閾值時正確觸發。

## 專案結構

```
spancer_spring_demo/
├── src/
│   ├── main/
│   │   ├── java/com/example/spancer_spring_demo/
│   │   │   ├── SpancerSpringDemoApplication.java  # 主程式入口
│   │   │   ├── HelloController.java               # REST API 控制器
│   │   │   └── GlobalExceptionHandler.java        # 全域異常處理器
│   │   └── resources/
│   │       └── application.properties              # 應用程式設定
│   └── test/
│       └── java/                                   # 單元測試
├── pom.xml                                         # Maven 專案設定
├── test_api.sh                                     # API 測試腳本
├── start_app.sh                                    # 啟動腳本
└── stop_app.sh                                     # 停止腳本
```

## 部署說明

詳細的部署指南請參考：
- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - 完整部署指南
- [README_DEPLOYMENT.md](README_DEPLOYMENT.md) - 部署說明
- [DEPLOY_COMMANDS.md](DEPLOY_COMMANDS.md) - 部署指令參考

## 監控端點

應用程式啟動後，可以存取以下監控端點：

- `http://localhost:8080/` - 主要 API 端點
- `http://localhost:8080/actuator/health` - 健康檢查
- `http://localhost:8080/actuator/metrics` - 應用程式指標

## 開發者資訊

**作者**：Spencer Hsieh

## 授權

本專案為示範用途，可自由使用和修改。
