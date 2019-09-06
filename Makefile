TAG=$(shell cat .image-tag)

build:
	docker build -t docker.pkg.github.com/8398a7/descheduler/descheduler:$(TAG) .
push:
	docker push docker.pkg.github.com/8398a7/descheduler/descheduler:$(TAG)
