.PHONY: all help build run builddocker rundocker kill rm-image rm clean enter logs

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make run       - build and run docker container
	@echo ""   2. make build     - build docker container
	@echo ""   3. make clean     - kill and remove docker container
	@echo ""   4. make enter     - execute an interactive bash in docker container
	@echo ""   3. make logs      - follow the logs of docker container

build: NAME TAG builddocker

# run a plain container
run: BRANCH PORT NAME TAG rm rundocker

rundocker:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	$(eval BRANCH := $(shell cat BRANCH))
	$(eval PORT := $(shell cat PORT))
	chmod 777 $(TMP)
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-e BRANCH=$(BRANCH) \
	-d \
	-p $(PORT):80 \
	-t $(TAG)

test: PORT NAME TAG rm testdocker

testdocker:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	$(eval PORT := $(shell cat PORT))
	chmod 777 $(TMP)
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-d \
	-p $(PORT):80 \
	-t $(TAG) bash -l -c 'node -v;npm -v; ruby -v; which sass; /bin/bash'

prod: PORT NAME TAG rm proddocker

proddocker:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	$(eval PORT := $(shell cat PORT))
	chmod 777 $(TMP)
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-d \
	-p $(PORT):80 \
	-t $(TAG) '/meanshop/prodstart.sh'

builddocker:
	/usr/bin/time -v docker build -t `cat TAG` .

kill:
	-@docker kill `cat cid`

rm-image:
	-@docker rm `cat cid`
	-@rm cid

rm: kill rm-image

clean: rm

enter:
	docker exec -i -t `cat cid` /bin/bash -l

logs:
	docker logs -f `cat cid`

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the tag you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;

BRANCH:
	@while [ -z "$$BRANCH" ]; do \
		read -r -p "Enter the branch you wish to work with e.g. 'master' [BRANCH]: " BRANCH; echo "$$BRANCH">>BRANCH; cat BRANCH; \
	done ;

PORT:
	@while [ -z "$$PORT" ]; do \
		read -r -p "Enter the tag you wish to associate with this container [PORT]: " PORT; echo "$$PORT">>PORT; cat PORT; \
	done ;

compose:
	docker-compose up

up: compose

pull:
	docker pull `cat TAG`
