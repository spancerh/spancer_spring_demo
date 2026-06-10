#!/bin/bash

echo "=== 使用 YUM 安裝 Java 17 ==="
echo "注意：此方法需要 sudo 權限"
echo ""

# 檢查是否有 sudo 權限
if ! sudo -n true 2>/dev/null; then
    echo "錯誤：需要 sudo 權限才能使用 yum 安裝"
    echo "請使用 setup_java.sh 進行使用者層級安裝"
    exit 1
fi

# 安裝 Java 17
echo "安裝 Java 17 OpenJDK..."
sudo yum install -y java-17-openjdk java-17-openjdk-devel

# 設定 JAVA_HOME
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which java))))

echo "" >> ~/.bashrc
echo "# Java 17 Environment" >> ~/.bashrc
echo "export JAVA_HOME=$JAVA_HOME_PATH" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# 立即載入環境變數
export JAVA_HOME=$JAVA_HOME_PATH
export PATH=$JAVA_HOME/bin:$PATH

echo "=== Java 17 安裝完成 ==="
echo "Java 版本:"
java -version
echo ""
echo "JAVA_HOME: $JAVA_HOME"
echo ""
echo "請執行: source ~/.bashrc"

# Made with Bob
