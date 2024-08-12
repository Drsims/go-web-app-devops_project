FROM golang:1.22.5 as base

WORKDIR /app

# Copies the application files to the working directory
COPY go.mod .

# Downloads all the application dependencies
RUN go mod download

# Copies the source code to the working directory
COPY . .

# BUild the application
RUN go build -o main .

# Reduce the image size 
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]

