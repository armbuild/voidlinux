REPO ?= armbuild/voidlinux
VERSION ?= 20150713
DEVICE ?= rpi2

all: build


.PHONY: build
build: rootfs-$(DEVICE)-$(VERSION).tar.xz
	rm -f rootfs.tar.xz
	cp $< rootfs.tar.xz
	docker build -t $(REPO):$(DEVICE)-$(VERSION) .
	docker tag -f $(REPO):$(DEVICE)-$(VERSION) $(REPO):$(DEVICE)
	docker tag -f $(REPO):$(DEVICE)-$(VERSION) $(REPO):latest
	rm -f rootfs.tar.xz


.PHONY: shell
shell:
	docker run -it --rm $(REPO):$(DEVICE)-$(VERSION)


.PHONY: push
push:
	docker push $(REPO)


rootfs-$(DEVICE)-$(VERSION).tar.xz:
	wget http://repo.voidlinux.eu/live/current/void-$(DEVICE)-rootfs-$(VERSION).tar.xz -O $@
