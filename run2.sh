# 建置（在專案根目錄）
#docker build -t myapp:local .

# 本地執行，對外開 8080
#docker run --rm -p 8080:8080 --name myapp myapp:local
#docker run --rm -p 8080:8080 --name myapp myapp:local 
#INSTANA_AGENT_HOST=host.docker.internal
INSTANA_AGENT_HOST=192.168.215.1
INSTANA_AGENT_PORT=42699

docker run -d \
  --name myapp \
  -p 8080:8080 \
  -e JAVA_TOOL_OPTIONS="-Dinstana.agent.host=192.168.215.1 -Dinstana.agent.port=42699" \
  -e INSTANA_AGENT_HOST=192.168.215.1 \
  -e INSTANA_AGENT_PORT=42699 \
  myapp:local

