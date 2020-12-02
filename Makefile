.PHONY: build
## build: builds thumbor docker image
build:
ifndef VERSION
	$(error Provide VERSION as env var)
endif
	@cd thumbor
	 docker build -t dffrntlab/thumbor:${VERSION} .

.PHONY: tag
## tag: tags current state
tag:
ifndef VERSION
	$(error Provide VERSION as env var)
endif
	@git tag -a "${VERSION}" -m "${VERSION}"
	 git push origin --tags

.PHONY: deploy
## deploy: deploys thumbor docker image to the Docker Hub
deploy:
ifndef VERSION
	$(error Provide VERSION as env var)
endif
	build
	tag
	@docker push dffrntlab/thumbor:${VERSION}

.PHONY: help
## help: prints help message
help:
	@echo "docker-thumbor"
	@echo
	@echo "Usage:"
	@echo
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'
	@echo
