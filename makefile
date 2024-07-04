.PHONY: build migrate-up migrate-down sqlc

build:
	docker-compose build

down:
	docker-compose down

up:
	docker-compose up

sqlc:
	docker-compose run app sqlc generate

