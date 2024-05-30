FROM maven:3.9.0

WORKDIR /app

COPY pom.xml .

COPY src ./src

WORKDIR /app


