FROM golang:1.21-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git

COPY go.mod go.sum ./
COPY . .
RUN go mod tidy && go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o evaluation-service .

FROM alpine:3.19 AS runtime

WORKDIR /app

RUN apk add --no-cache ca-certificates

COPY --from=builder /app/evaluation-service .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 8004

CMD ["./evaluation-service"]
