define USAGE
Usage: make [COMMAND]
 server		Start server
 secrets	Generate credentials in environment variables file
 tables		Create an SQLite database for bookmark feature
endef

RACKET = env -S $$(cat .env) racket

.PHONY: help
help:
	@echo -n ''
	$(info $(USAGE))

.PHONY: server
server:
	@$(RACKET) -t src/app.rkt

.PHONY: secrets
secrets:
	@$(RACKET) -t src/scripts/generate_secrets.rkt

.PHONY: tables
tables:
	@$(RACKET) -t src/scripts/create_tables.rkt
