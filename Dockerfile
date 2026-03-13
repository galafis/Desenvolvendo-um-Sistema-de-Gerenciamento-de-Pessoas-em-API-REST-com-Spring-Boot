FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN if [ -f mvnw ]; then chmod +x mvnw && ./mvnw package -DskipTests; else mvn package -DskipTests; fi

FROM eclipse-temurin:21-jre-alpine

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
