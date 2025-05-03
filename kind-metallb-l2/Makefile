.PHONY: create-cluster
create-cluster:
	kind create cluster --config kind-1.yaml
.PHONY: install-metallb
install-metallb:
	./install-metallb.sh
.PHONY: destroy-cluster
destroy-cluster:
	kind delete clusters kind-1 
.PHONY: deploy-app
deploy-app:
	kubectl apply -f ./demo-app.yaml
	