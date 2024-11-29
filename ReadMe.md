# WSO2 Bash Scripts
WSO2 Bash Scripts provide automated installation and uninstallation of WSO2 APK and Kong Gateway using bash scripts.

## Prerequisites
- Kubernetes 1.30.6
- Helm
- kubectl

## APK Folder
The `apk` folder contains scripts and configuration files for installing and uninstalling WSO2 APK.

- **[apk/config.sh](apk/config.sh)**: Configuration script with default values and argument parsing.
- **[apk/install.sh](apk/install.sh)**: Script to install APK with Control Plane.
- **[apk/uninstall.sh](apk/uninstall.sh)**: Script to uninstall APK with Control Plane.

### Usage
1. **Install APK**: Run `./apk/install.sh -n=<namespace> -h_apim=<helm_name_for_apim> -h_apk=<helm_name_for_apk> -h_agent=<helm_name_for_apim_apk_agent>` to install the APK with the Control Plane.
2. **Uninstall APK**: Run `./apk/uninstall.sh -n=<namespace> -h_apim=<helm_name_for_apim> -h_apk=<helm_name_for_apk> -h_agent=<helm_name_for_apim_apk_agent>` to uninstall the APK with the Control Plane.

## Kong Folder
The `kong` folder contains scripts and configuration files for installing and uninstalling Kong Gateway.

- **[kong/config.sh](kong/config.sh)**: Configuration script for Kong Gateway.
- **[kong/gateway-class.yaml](kong/gateway-class.yaml)**: YAML configuration for GatewayClass.
- **[kong/gateway.yaml](kong/gateway.yaml)**: YAML configuration for Gateway.
- **[kong/install.sh](kong/install.sh)**: Script to install Kong Gateway.
- **[kong/uninstall.sh](kong/uninstall.sh)**: Script to uninstall Kong Gateway.

### Usage
1. **Install Kong Gateway**: Run `./kong/install.sh -n=<namespace> -h=<helm_name>` to install the Kong Gateway.
2. **Uninstall Kong Gateway**: Run `./kong/uninstall.sh -n=<namespace> -h=<helm_name>` to uninstall the Kong Gateway.