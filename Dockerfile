# ---- build stage（有 Maven）----
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# 先複製 pom 以利用快取
COPY pom.xml .
RUN mvn -B -q -DskipTests dependency:go-offline

# 再複製原始碼並打包
COPY src ./src
# 若你專案有 wrapper（mvnw/.mvn），也可 COPY . . 改用 ./mvnw
RUN mvn -B -q -DskipTests package

# ---- runtime stage（只要 JRE）----
FROM eclipse-temurin:21-jre
WORKDIR /app

# 建議用非 root
RUN useradd -m appuser
USER appuser

# 拷貝 JAR；請視你的成品檔名調整
COPY --from=build /app/target/*SNAPSHOT*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-XX:MaxRAMPercentage=75.0","-jar","/app/app.jar"]
