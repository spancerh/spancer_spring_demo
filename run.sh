# 建置（在專案根目錄）
docker build -t myapp:local .

# 本地執行，對外開 8080
docker run --rm -p 8080:8080 --name myapp myapp:local
