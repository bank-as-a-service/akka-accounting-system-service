# Dockerfile
# Use a lightweight OpenJDK image as the base image
FROM eclipse-temurin:21-jdk AS build

# Install Maven
RUN apt-get update
RUN apt-get install -y maven && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy Maven configuration and project files to the container
COPY pom.xml ./
RUN mkdir -p ~/.m2 && mvn dependency:go-offline -B

# Build the application using Maven in a multi-stage build
COPY src ./src
RUN mvn -B clean package -DskipTests

# Use a smaller JRE image for the runtime stage
FROM eclipse-temurin:21-jre

# Set environment variables
#ENV OPENAI_API_KEY=<your-openai-api-key>

# Set the working directory for the final container
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/target/akka-accounting-system-service-*.jar app.jar

# Expose the port your application listens on
EXPOSE 9000

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]