# How to Use the Resources

This document provides instructions on how to use the resources for different types of authentication: Basic, JWT, and API Key. We will be using the Echo service for demonstration purposes. Ensure that the Echo service is up and running before proceeding.

## Prerequisites
- Kubernetes cluster
- Echo service deployed
- kubectl configured to interact with your cluster

## Authentication Types

### Basic Authentication
1. Navigate to the `basic-auth` folder:
    ```sh
    cd /path/to/basic-auth
    ```
2. Apply the following YAML files in order:
    ```sh
    kubectl apply -f plugin.yaml -n kong
    kubectl apply -f secret.yaml -n kong
    kubectl apply -f consumer.yaml -n kong
    ```
3. Annotate the Echo service:
    ```sh
    kubectl annotate service echo konghq.com/plugins=basic-auth --overwrite -n kong
    ```

### JWT Authentication
1. Navigate to the `jwt-auth` folder:
    ```sh
    cd /path/to/jwt-auth
    ```
2. Apply the following YAML files in order:
    ```sh
    kubectl apply -f plugin.yaml -n kong
    kubectl apply -f secret.yaml -n kong
    kubectl apply -f consumer.yaml -n kong
    ```
3. Annotate the Echo service:
    ```sh
    kubectl annotate service echo konghq.com/plugins=jwt-auth --overwrite -n kong
    ```

### API Key Authentication
1. Navigate to the `key-auth` folder:
    ```sh
    cd /path/to/key-auth
    ```
2. Apply the following YAML files in order:
    ```sh
    kubectl apply -f plugin.yaml -n kong
    kubectl apply -f secret.yaml -n kong
    kubectl apply -f consumer.yaml -n kong
    ```
3. Annotate the Echo service:
    ```sh
    kubectl annotate service echo konghq.com/plugins=key-auth --overwrite -n kong
    ```

By following these steps, you can configure different types of authentication for your Echo service using Kong.