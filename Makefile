dev: up exemple

clippy:
	cargo clippy --fix --all-features -- -D warnings
	cargo clippy --all-features -- -D warnings

fmt:
	cargo fmt -- --emit files

up:
	docker compose up -d --remove-orphans

stop:
	docker compose stop

down:
	docker compose down -v --remove-orphans

exemple:
	$(MAKE) _exemple -j2

_exemple: exemple.actix-web exemple.axum

exemple.actix-web:
	cargo run --bin actix-web

exemple.axum:
	cargo run --bin axum

token:
	curl -X POST http://127.0.0.1:6550/oauth/token \
		-H 'Content-Type: application/json' \
		-d '{"client_id": "john.doe"}'

hello.actix-web:
	curl http://127.0.0.1:3000/hello \
		-H 'Authorization: Bearer $(token)'

hello.axum:
	curl http://127.0.0.1:3001/hello \
		-H 'Authorization: Bearer $(token)'
