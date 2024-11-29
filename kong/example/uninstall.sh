#! /bin/bash

# Source the configuration file
source ../config.sh "$@" 

echo $'\n# Uninstall httproute #'
kubectl delete -f httproute.yaml -n $namespace

echo $'\n# Uninstall echo service #'
kubectl delete -f https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml -n $namespace

echo $'\n=== Completed ==='