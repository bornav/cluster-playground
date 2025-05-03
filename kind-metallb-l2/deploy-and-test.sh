#!/usr/bin/env sh

echo "create Kind cluster"
make create-cluster

echo "deploy sample app"
make deploy-app

echo "deploy metallb"
make install-metallb

echo "curl loadbalancer"
sleep 1
curl $(kubectl get service nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "cleanup"
make destroy-cluster