FROM gradle:6.8.3-jdk11 as builder

WORKDIR /app

ARG JAVA_OPTS=""

COPY . .

RUN gradle build && cp /app/build/libs/app-0.3-SNAPSHOT.jar /app.jar

FROM adoptopenjdk:11.0.11_9-jre-hotspot

COPY --from=builder /app.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
