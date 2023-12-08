# Stage 1: Building the Java application
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copying pom.xml to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copying source code and building the application
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run Stage
FROM openjdk:17-alpine
WORKDIR /app

# Copying built JAR file from the build stage
COPY --from=build /app/target/demo.jar ./app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
