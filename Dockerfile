# ---------- Build stage ----------
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

# Copy project files
COPY . .

# Build the Spring Boot jar
RUN mvn clean package -DskipTests


# ---------- Runtime stage ----------
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copy jar from build stage
COPY --from=build /build/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]