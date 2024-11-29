#! /bin/bash

source ../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ./config.sh "$@" 

echo $'### Installing Kong Gateway ###'
echo $'namespace: '$namespace$''
echo $'helm name: '$helm_name$''

echo $'\n# Create namespace #'
kubectl create ns $namespace

echo $'\n# Install Kong gateway CRDs #'
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

echo $'\n# Create gateway CRD #'
kubectl apply -f gateway-class.yaml

echo $'\n# Create gateway CR #'
kubectl apply -f gateway.yaml -n $namespace

echo $'\n# Add Kong repo #'
helm repo add kong https://charts.konghq.com
helm repo update

echo $'\n# Install Kong ingress controller #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install $helm_name kong/ingress -n $namespace
BLA::stop_loading_animation


echo $'\n=== Installation completed ==='
echo 'Refer: https://docs.konghq.com/kubernetes-ingress-controller/latest/get-started'