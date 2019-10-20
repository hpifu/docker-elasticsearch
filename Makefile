version=$(shell git describe --tags)
repository=elasticsearch
user=hatlonely

.PHONY: deploy remove build push

deploy:
	mkdir -p /var/docker/${repository}/data
	mkdir -p /var/docker/${repository}/log
	chown -R 1000:1000 /var/docker/${repository}/data
	chown -R 1000:1000 /var/docker/${repository}/log
	docker stack deploy -c stack.yml ${repository}

remove:
	docker stack rm ${repository}

build:
	docker build --tag=${user}/${repository}:${version} .
	cat stack.tpl.yml | sed 's/\$${version}/${version}/g' | sed 's/\$${repository}/${repository}/g' > stack.yml

push:
	docker push ${user}/${repository}:${version}

logs:
	docker logs $$(docker ps --filter name=$(repository) -q)
