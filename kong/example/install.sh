#! /bin/bash

# Source the configuration file
source ../config.sh "$@" 

echo $'\n# Install echo service #'
kubectl apply -f https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml -n $namespace

echo $'\n# Install httproute #'
kubectl apply -f ./httproute.yaml -n $namespace

echo $'\n=== Completed ==='