# Start from a lightweight base image for Go
FROM golang:1.22-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy Go modules and source code
COPY go.mod go.sum ./
RUN go mod download
COPY . .

# Build the Go application
RUN go build -o main .

# Expose the port your app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./main"]