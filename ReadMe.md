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

```bash
# port forward apk gateway service
kubectl port-forward -n apk svc/apk-wso2-apk-gateway-service 9095
# port forward ingress controller
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 443
```

> [!TIP]
> Allow non-root users to bind to privileged ports:
>
> Run the following command:
> ```bash
> sudo sysctl -w net.ipv4.ip_unprivileged_port_start=80
> ```
>
> Make it permanent by adding this line to /etc/sysctl.conf:
> ```bash
> net.ipv4.ip_unprivileged_port_start=80
> ```

### Usage
1. **Install APK**: Run `./apk/install.sh -n=<namespace> -h_apim=<helm_name_for_apim> -h_apk=<helm_name_for_apk> -h_agent=<helm_name_for_apim_apk_agent>` to install the APK with the Control Plane.
2. **Uninstall APK**: Run `./apk/uninstall.sh -n=<namespace> -h_apim=<helm_name_for_apim> -h_apk=<helm_name_for_apk> -h_agent=<helm_name_for_apim_apk_agent>` to uninstall the APK with the Control Plane.

## Kong Folder
The `kong` folder contains scripts and configuration files for installing and uninstalling Kong Gateway.

- **[kong/config.sh](kong/config.sh)**: Configuration script with default values and argument parsing.
- **[kong/gateway-class.yaml](kong/gateway-class.yaml)**: YAML configuration for GatewayClass.
- **[kong/gateway.yaml](kong/gateway.yaml)**: YAML configuration for Gateway.
- **[kong/install.sh](kong/install.sh)**: Script to install Kong Gateway.
- **[kong/uninstall.sh](kong/uninstall.sh)**: Script to uninstall Kong Gateway.

### Usage
1. **Install Kong Gateway**: Run `./kong/install.sh -n=<namespace> -h=<helm_name>` to install the Kong Gateway.
2. **Uninstall Kong Gateway**: Run `./kong/uninstall.sh -n=<namespace> -h=<helm_name>` to uninstall the Kong Gateway.

## Kong Example Folder
The `kong/example` folder contains example scripts and configuration files for setting up a sample environment with Kong Gateway ingress example service.

- **[kong/example/httproute.yaml](kong/example/sample-app.yaml)**: YAML configuration for a sample HTTPROUTE.
- **[kong/example/install.sh](kong/example/install.sh)**: Script to install the sample application with Kong Gateway.
- **[kong/example/uninstall.sh](kong/example/uninstall.sh)**: Script to uninstall the sample application with Kong Gateway.

### Usage
1. **Install Sample Application**: Run `./kong/example/install.sh -n=<namespace> -h=<helm_name>` to install the sample application with Kong Gateway.
2. **Uninstall Sample Application**: Run `./kong/example/uninstall.sh -n=<namespace> -h=<helm_name>` to uninstall the sample application with Kong Gateway.

## Kong Gateway With Control Plane and Data Plane
The `kong/cp-dp` folder contains example scripts and configuration files for setting up a sample environment with Kong Gateway.

### Usage
1. **Install**: Run `./kong/cp-dp/install.sh -n=<namespace>` to install the Kong Gateway.
2. **Uninstall**: Run `./kong/cp-dp/uninstall.sh -n=<namespace>` to uninstall the Kong Gateway.

```bash
# port forward proxy
kubectl port-forward -n kong service/kong-dp-kong-proxy 80
# port forward admin api
kubectl port-forward -n kong service/kong-cp-kong-admin 8001
```