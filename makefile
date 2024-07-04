.PHONY: build migrate-up migrate-down sqlc

build:
	docker-compose build

down:
	docker-compose down

up:
	docker-compose up

migrate-up:
	docker-compose run app goose postgres postgres://postgres:postgres@localhost:5432/go-iris-api-test up

migrate-down:
	docker-compose run app goose postgres postgres://postgres:postgres@localhost:5432/go-iris-api-test down

sqlc:
	sqlc generate
