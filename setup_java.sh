#!/bin/bash

echo "=== 開始安裝 Java 17 ==="

# 下載 Adoptium OpenJDK 17 (Eclipse Temurin)
cd ~
echo "下載 OpenJDK 17..."
wget -O openjdk-17.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz

# 解壓縮
echo "解壓縮中..."
tar -xzf openjdk-17.tar.gz

# 找到解壓後的目錄名稱
JDK_DIR=$(ls -d jdk-17* | head -1)

echo "Java 目錄: $JDK_DIR"

# 設定環境變數
echo "" >> ~/.bashrc
echo "# Java 17 Environment" >> ~/.bashrc
echo "export JAVA_HOME=\$HOME/$JDK_DIR" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# 立即載入環境變數
export JAVA_HOME=$HOME/$JDK_DIR
export PATH=$JAVA_HOME/bin:$PATH

echo "=== Java 17 安裝完成 ==="
echo "Java 版本:"
java -version
echo ""
echo "請執行: source ~/.bashrc"
echo "確保環境變數在新的 shell 中生效"

# Made with Bob
