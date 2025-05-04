#!/usr/bin/env sh


# echo "cleanup"
# make destroy-cluster

echo "create Kind cluster"
make create-cluster

echo "deploy sample app"
make deploy-app

echo "deploy kubevip"
make install-kube-vip

sleep 1
LBIP=$(kubectl get service nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "curl loadbalancer  $LBIP"
curl $LBIP

echo "cleanup"
make destroy-cluster