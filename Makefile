owner?=dgellow
image?=idris
full_image?=${owner}/${image}
versions?=0.12 0.99 0.99.1

release: clean build push clean

build:
	docker build --pull -t ${full_image}:latest .
	$(foreach v,${versions},docker build --build-arg version=-${v} --pull -t ${full_image}:v${tag} . &&) true
push:
	docker push ${full_image}:latest
	$(foreach v,${versions},docker push ${full_image}:${v} &&) true
clean:
	docker rmi -f ${full_image}:latest | true
	$(foreach v,${versions},docker rmi -f ${full_image}:${v} | true &&) true
