#! /bin/bash

source ../../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ../config.sh "$@" 

echo $'### Installing Agent With Control Plane (Portal Driven) ###'
echo $'namespace: '$namespace$''
echo $'ingress namespace: ingress-nginx'
echo $'helm APIM name: '$helm_apim_name$''
echo $'helm APIM Agent name: '$helm_agent_name$''

echo $'\n# Create namespace #'
kubectl create ns $namespace

echo $'\n# Add Gateway CRDS #'
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml

echo $'\n# Add Kong gateway CRDs #'
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

echo $'\n# Create gateway CRD #'
kubectl apply -f gateway-class.yaml

echo $'\n# Create gateway CR #'
kubectl apply -f gateway.yaml -n $namespace

echo $'\n# Add APIM CP, DP APIM-APK Agent, Kong repos #'
helm repo add wso2apim https://github.com/wso2/helm-apim/releases/download/cp-4.4.0
helm repo add kong https://charts.konghq.com
helm repo update

echo $'\n# Install APIM CP #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install $helm_apim_name wso2apim/wso2am-cp --version 4.4.0-1 -f https://raw.githubusercontent.com/wso2/apk/main/helm-charts/samples/apim/cp/4.4.0-values.yaml -n $namespace
BLA::stop_loading_animation

echo $'\n# Install Nginx Ingress #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
BLA::stop_loading_animation

echo $'\n# Install Kong Ingress #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install kong kong/ingress -n $namespace -f ./kong-helm/values.yaml
BLA::stop_loading_animation

echo $'\n# Install APIM Agent #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm install $helm_agent_name ./apk-helm/. -n $namespace
BLA::stop_loading_animation


echo $'\n=== Installation completed ==='