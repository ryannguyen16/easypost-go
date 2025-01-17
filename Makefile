PROJECT_NAME := easypost-go
PROJECT_PATH := $$(go env GOPATH)/bin/$(PROJECT_NAME)
DIST_PATH := dist

## help - Display help about make targets for this Makefile
help:
	@cat Makefile | grep '^## ' --color=never | cut -c4- | sed -e "`printf 's/ - /\t- /;'`" | column -s "`printf '\t'`" -t

## build - Build the project
build:
	go build -o ../$(DIST_PATH)/$(PROJECT_NAME)

## clean - Clean the project
clean:
	rm -rf $(DIST_PATH)
	rm $(PROJECT_PATH)

## coverage - Get test coverage and open it in a browser
coverage: 
	go clean -testcache && go test ./tests -coverprofile=covprofile -coverpkg=./... && go tool cover -html=covprofile

## gosec - Run gosec to scan for security issues
gosec:
	gosec ./...

## install - Install and vendor dependencies
install:
	go mod vendor
	go build -o $(PROJECT_PATH)

## lint - Lint the project
lint:
	golangci-lint run

## test - Test the project
test:
	go clean -testcache && go test ./tests

## tidy - Tidies up the vendor directory
tidy:
	go mod tidy

.PHONY: help build clean coverage gosec install lint test tidy
