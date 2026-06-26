# ===========================
# Build Stage
# ===========================
FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-s -w" \
    -o cloudforge-monitoring \
    ./cmd/cloudforge-monitoring

# ===========================
# Runtime Stage
# ===========================
FROM alpine:3.21

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY --from=builder /app/cloudforge-monitoring .

EXPOSE 8080

USER nobody

ENTRYPOINT ["./cloudforge-monitoring"]
