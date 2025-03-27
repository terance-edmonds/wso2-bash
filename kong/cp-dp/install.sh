#! /bin/bash

source ../../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ../config.sh "$@" 

echo $'### Installing Kong Gateway ###'
echo $'namespace: '$namespace$''

echo $'\n# Create namespace #'
kubectl create ns $namespace

echo $'\n# Add Kong repo #'
helm repo add kong https://charts.konghq.com
helm repo update

echo $'\n# Install Kong gateway CRDs #'
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

echo $'\n# Create gateway CRD #'
kubectl apply -f gateway-class.yaml

echo $'\n# Create gateway CR #'
kubectl apply -f gateway.yaml -n $namespace

echo $'\n# Create kong enterprise free mode license #'
kubectl create secret generic kong-enterprise-license --from-literal=license="'{}'" -n $namespace

echo $'\n# Generate TLS certificate #'
openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -keyout ./tls.key -out ./tls.crt -days 1095 -subj "/CN=kong_clustering"

echo $'\n# Create k8s secret containing the certificate #'
kubectl create secret tls kong-cluster-cert --cert=./tls.crt --key=./tls.key -n $namespace

echo $'\n# Install kong control plane #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install kong-cp kong/kong -n $namespace --values ./values-cp.yaml
sleep 20 # wait for 20 seconds
BLA::stop_loading_animation

echo $'\n# Install kong data plane #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install kong-dp kong/kong -n $namespace --values ./values-dp.yaml
BLA::stop_loading_animation

echo $'\n=== Installation completed ==='
echo 'Refer: https://docs.konghq.com/gateway/latest/install/kubernetes/proxy'