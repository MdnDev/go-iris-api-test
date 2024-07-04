# syntax=docker/dockerfile:1

# Start with the official Golang image for building the application
FROM golang:1.22-alpine AS builder

# Set environment variables for the build stage
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# Create and set the working directory in the build stage
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Install goose and sqlc tools
RUN go install github.com/pressly/goose/v3/cmd/goose@latest
RUN go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o go-iris-api-test .

# Use a minimal base image for the final stage
FROM alpine:latest

# Set the working directory in the final stage
WORKDIR /root/

# Copy the Go application binary from the builder stage
COPY --from=builder /app/go-iris-api-test /usr/local/bin/go-iris-api-test

# Copy the installed tools from the builder stage
COPY --from=builder /go/bin /go/bin

# Ensure the tools are in the PATH
ENV PATH="/go/bin:${PATH}"

# Copy the migrations
COPY --from=builder /app/sql/migrations /migrations

# Copy the .env file
COPY --from=builder /app/.env /root/.env

# Command to run the Go application
CMD ["go-iris-api-test"]
