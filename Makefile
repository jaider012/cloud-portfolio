TF_DIRS := bootstrap modules/network week1-static-site/terraform week2-vpc-lab/terraform week3-containers-api/terraform

.PHONY: check fmt validate test docker-build

check: fmt validate test ## Everything CI runs, locally

fmt:
	@for d in $(TF_DIRS); do terraform -chdir=$$d fmt -check || exit 1; done

validate:
	@for d in $(TF_DIRS); do \
		terraform -chdir=$$d init -backend=false -input=false >/dev/null && \
		terraform -chdir=$$d validate || exit 1; \
	done

test:
	cd week3-containers-api/api && npm test

docker-build:
	docker build -t shortener-api week3-containers-api/api
