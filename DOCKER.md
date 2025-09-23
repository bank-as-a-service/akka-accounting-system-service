
# Docker Instructions for Akka Service

This guide provides instructions for containerizing and running the Akka-based service using Docker.

## Prerequisites

- Docker must be installed on your system. You can download it from [here](https://www.docker.com/get-started).

## Steps to Build and Run Docker Container

### 1. Build the Docker Image

Ensure you have the `Dockerfile` in the root of your project. Then, execute the following command to build the Docker image:

```shell
docker build -t akka-accounting-system-service:latest .
```

### 2. Run the Docker Container

Once the image is built, run the container by specifying the necessary environment variable (`OPENAI_API_KEY`):
```shell
docker run -p 9000:9000 -e OPENAI_API_KEY=your-openai-api-key akka-accounting-system-service:latest
```
