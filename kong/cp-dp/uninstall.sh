#!/bin/bash

source ../../loader.sh
trap BLA::stop_loading_animation SIGINT

# Source the configuration file
source ../config.sh "$@"

echo $'### Uninstalling Kong Gateway ###'
echo $'namespace: '$namespace$''

echo $'\n# Uninstall Kong data plane #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall kong-dp -n $namespace
BLA::stop_loading_animation

echo $'\n# Uninstall Kong control plane #'
BLA::start_loading_animation "${BLA_braille_whitespace[@]}"
helm uninstall kong-cp -n $namespace
BLA::stop_loading_animation

echo $'\n# Delete secrets #'
kubectl delete secret kong-enterprise-license -n $namespace
kubectl delete secret kong-cluster-cert -n $namespace

echo $'\n# Delete namespace #'
kubectl delete namespace $namespace

echo $'\n=== Uninstallation completed ==='