.PHONY: help

gen-go:
	protoc --proto_path=./proto --go-grpc_out=./go --go_out=./go ./proto/*.proto
.PHONY: protoc