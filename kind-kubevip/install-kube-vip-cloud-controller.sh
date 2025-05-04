#!/usr/bin/env sh

set -e
set -o pipefail

kubectl apply -f https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml

kubectl wait --for=condition=Ready pods --all --all-namespaces --timeout=300s


kubectl apply -f kube-vip.yaml


kubectl apply -f https://kube-vip.io/manifests/rbac.yaml

export KVVERSION=v0.9.1

# alias kube-vip="ctr image pull ghcr.io/kube-vip/kube-vip:$KVVERSION; ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:$KVVERSION vip /kube-vip"   # containerd
alias kube-vip="docker run --network host --rm ghcr.io/kube-vip/kube-vip:$KVVERSION" # docker

kube-vip manifest daemonset --services --inCluster --arp --interface eth0 | kubectl apply -f -

sleep 5

kubectl wait --for=condition=Ready pods --all --all-namespaces --timeout=300s

sleep 1
