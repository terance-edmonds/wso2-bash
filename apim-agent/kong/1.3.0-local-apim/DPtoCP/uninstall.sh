#!/bin/bash

source ../../../../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ../../../config.sh "$@"

echo $'\n### Uninstalling Agent With Control Plane (Portal Driven) ###'
echo $'namespace: '$namespace$''
echo $'ingress namespace: ingress-nginx'
echo $'helm APIM name: '$helm_apim_name$''
echo $'helm APIM Agent name: '$helm_agent_name$''

echo $'\n# Uninstall APIM Agent #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall $helm_agent_name -n $namespace
BLA::stop_loading_animation

echo $'\n# Uninstall Nginx Ingress #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall kong -n $namespace
BLA::stop_loading_animation

echo $'\n# Uninstall APIM CP #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall $helm_apim_name -n $namespace
BLA::stop_loading_animation

echo $'\n# Uninstall Nginx Ingress #'
helm uninstall ingress-nginx -n ingress-nginx

echo $'\n# Remove Gateway CRDS #'
kubectl remove -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml

echo $'\n# Remove Kong gateway CRDs #'
kubectl remove -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

echo $'\n# Delete namespace #'
kubectl delete ns $namespace --ignore-not-found
kubectl delete ns ingress-nginx

echo $'\n=== Uninstallation completed ==='
