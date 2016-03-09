CONTAINER = tvaughan/shout-volume
VERSION = 1

.PHONY = all .run-always build clean

VOLUME = $(shell find volume -type f | sort | xargs shasum)

all: build

.run-always:

.volume: .run-always
	@echo $(VOLUME) | cmp -s - $@ || echo $(VOLUME) > $@

.built: Dockerfile .volume
	@docker build -t $(CONTAINER):$(VERSION) .
	@touch $@

build: .built

clean:
	@rm -f .built .soruce
