build:
	go build -o bin/cloudforge-monitoring ./cmd/cloudforge-monitoring

run:
	go run ./cmd/cloudforge-monitoring

test:
	go test ./...

docker-build:
	docker build -t cloudforge-monitoring .

docker-run:
	docker run -p 8080:8080 cloudforge-monitoring

clean:
	rm -rf bin
