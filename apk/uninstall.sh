#!/bin/bash

source ../loader.sh
trap BLA::stop_loading_animation SIGINT

BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
# Source the configuration file
source ./config.sh "$@" 

echo $'### Uninstalling APK With Control Plane (Developer Driven) ###'
echo $'namespace: '$namespace$''
echo $'helm APIM name: '$helm_apim_name$''
echo $'helm APK name: '$helm_apk_name$''
echo $'helm APIM-APK Agent name: '$helm_agent_name$''

echo $'\n# Uninstall APIM-APK Agent #'
helm uninstall $helm_agent_name -n $namespace

echo $'\n# Uninstall APK DP #'
helm uninstall $helm_apk_name -n $namespace

echo $'\n# Uninstall APIM CP #'
helm uninstall $helm_apim_name -n $namespace

echo $'\n# Uninstall Nginx Ingress #'
helm uninstall ingress-nginx -n $namespace

echo $'\n# Remove Helm repositories #'
helm repo remove wso2apim
helm repo remove wso2apk
helm repo remove wso2apkagent
helm repo remove ingress-nginx

echo $'\n# Delete namespace #'
kubectl delete ns $namespace

echo $'\n=== Uninstall completed ==='
BLA::stop_loading_animation
