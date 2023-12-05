# Stage 1: Build the application
FROM gradle:7.2-jdk11 AS builder

WORKDIR /usr/src/app

COPY . .

# Build the Gradle project
RUN gradle build

# Stage 2: Copy the built artifact to Tomcat
FROM tomcat:9.0-jdk11-corretto

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file from the builder stage
COPY --from=builder /usr/src/app/build/libs/*.war ./ROOT.war

# Start Tomcat
CMD ["catalina.sh", "run"]
