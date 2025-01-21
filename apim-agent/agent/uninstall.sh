#!/bin/bash

source ../../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ../config.sh "$@"

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
helm uninstall ingress-nginx -n ingress-nginx
kubectl delete ns ingress-nginx --ignore-not-found
BLA::stop_loading_animation

echo $'\n# Uninstall APIM CP #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall $helm_apim_name -n $namespace
BLA::stop_loading_animation

echo $'\n# Delete namespace #'
kubectl delete ns $namespace --ignore-not-found

echo $'\n=== Uninstallation completed ==='
