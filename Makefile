################################################################################
# Heroku variables
################################################################################
HEROKU_APP_NAME := actix-hello-world

################################################################################
# Heroku task
################################################################################
.PHONY: heroku-login
heroku-login: ## heroku login
	heroku login --interactive

.PHONY: heroku-create-app
heroku-create-app: ## heroku create ${HEROKU_APP_NAME}
	(heroku apps | grep $(HEROKU_APP_NAME)) || heroku create $(HEROKU_APP_NAME)

.PHONY: heroku-container-login
heroku-container-login: ## heroku container:login
	heroku container:login

.PHONY: heroku-build
heroku-build: ## heroku用のtagを付けたDocker imageをbuild
	docker build . --tag registry.heroku.com/$(HEROKU_APP_NAME)/web

.PHONY: heroku-push
heroku-push: ## heroku用のtagを付けたDocker imageをpush
	docker push registry.heroku.com/$(HEROKU_APP_NAME)/web

.PHONY: heroku-release
heroku-release: ## heroku で release
	heroku container:release web
