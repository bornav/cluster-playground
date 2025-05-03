#!/usr/bin/env sh

set -e
set -o pipefail

helm repo add cilium https://helm.cilium.io/

helm upgrade -i cilium cilium/cilium \
    --version 1.17.3 \
    --namespace kube-system \
    --kube-context kind-kind-1 \
    --values cilium-values.yaml \
    --wait 

sleep 5
kubectl wait --for=condition=Ready pods --all --all-namespaces --timeout=300s

kubectl apply -f cilium-l2.yaml

sleep 2

