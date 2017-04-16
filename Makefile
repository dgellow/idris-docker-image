owner?=dgellow
image?=idris
base_image?=${owner}/${image}-base
full_image?=${owner}/${image}
versions?=0.12.3 0.99 0.99.1 1.0

release: clean build-base push-base build push clean

build-base:
	docker build --pull -t ${base_image}:latest -f Dockerfile_base .

build:
	docker build --build-arg VERSION=-1.0 --pull -t ${full_image}:latest .
	$(foreach v,${versions},docker build --build-arg VERSION=-${v} --pull -t ${full_image}:v${v} . &&) true

push-base:
	docker push ${base_image}:latest

push:
	docker push ${full_image}:latest
	$(foreach v,${versions},docker push ${full_image}:v${v} &&) true

clean:
	docker rmi -f ${base_image}:latest | true
	docker rmi -f ${full_image}:latest | true
	$(foreach v,${versions},docker rmi -f ${full_image}:v${v} | true &&) true
