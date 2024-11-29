#!/bin/bash

source ../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ./config.sh "$@" 

echo $'### Uninstalling Kong Gateway ###'
echo $'namespace: '$namespace$''
echo $'helm name: '$helm_name$''

echo $'\n# Uninstall Kong ingress controller #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall $helm_name -n $namespace
BLA::stop_loading_animation

echo $'\n# Remove gateway CR in namespace: '$namespace
kubectl delete -f gateway.yaml -n $namespace

echo $'\n# Remove gateway CRD #'
kubectl delete -f gateway-class.yaml

echo $'\n# Remove Kong repo #'
helm repo remove kong

echo $'\n# Uninstall Kong gateway CRDs #'
kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

echo $'\n# Delete namespace #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
kubectl delete ns $namespace --ignore-not-found
BLA::stop_loading_animation

echo $'\n=== Uninstall completed ==='