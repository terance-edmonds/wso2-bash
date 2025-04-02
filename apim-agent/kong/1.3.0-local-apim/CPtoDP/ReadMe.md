# Building and Deploying WSO2 API Manager - API Control Plane (APIM-ACP)

## 1. Build APIM-ACP Locally

### Clone the APIM Product Repository
Clone the WSO2 API Manager product repository:
```bash
git clone https://github.com/wso2/product-apim.git
```
We will be using the **API Control Plane (ACP)** module:
```bash
cd product-apim/api-control-plane
```

### Build the Project
Use Maven to build the project:
```bash
mvn clean install
```

### Locate the Build Artifact
After the build completes, navigate to:
```bash
cd api-control-plane/modules/distribution/product/target
```
Locate and extract the build artifact:
```bash
wso2am-acp-4.5.0-SNAPSHOT.zip
```

---

## 2. Update UI Changes

### Extract the Build Artifact
```bash
unzip wso2am-acp-4.5.0-SNAPSHOT.zip
```

### Clone APIM Apps Repository
Clone the APIM Apps repository:
```bash
git clone https://github.com/wso2/apim-apps.git
cd apim-apps
```
Build the project:
```bash
mvn clean install
```

### Update Publisher UI
Copy the updated **Publisher UI** files:
```bash
cp -r apim-apps/portals/publisher/src/main/webapp/site/public \
    wso2am-acp-4.5.0-SNAPSHOT/repository/deployment/server/webapps/publisher/site/public
```

### Update Developer Portal UI
Copy the updated **Developer Portal UI** files:
```bash
cp -r apim-apps/portals/devportal/src/main/webapp/site/public \
    wso2am-acp-4.5.0-SNAPSHOT/repository/deployment/server/webapps/devportal/site/public
```

### Add Drop-ins (Optional: Needed for Onboarding a New Gateway)
If required, copy the relevant `.jar` file into the `dropins` directory:
```bash
cp your-plugin.jar wso2am-acp-4.5.0-SNAPSHOT/repository/components/dropins/
```

### Fix Missing `api-manager.sh` Issue (if needed)
If you encounter a **"api-manager.sh not found"** error, copy the script from the **APIM Helm Chart**:
```bash
cp apim-helm/control-plane/assets/api-manager.sh wso2am-acp-4.5.0-SNAPSHOT/bin/
```

### Repackage the Build Artifact
Recreate the `.zip` file:
```bash
zip -r wso2am-acp-4.5.0-SNAPSHOT.zip wso2am-acp-4.5.0-SNAPSHOT/
```
Copy the updated zip file to the Helm assets directory:
```bash
cp wso2am-acp-4.5.0-SNAPSHOT.zip apim-agent/kong/1.3.0-local-apim/CPtoDP/apim-helm/control-plane/assets/
```

---

## 3. Build and Run Docker Image

### Build the Docker Image
Navigate to the assets directory and build the Docker image:
```bash
cd apim-agent/kong/1.3.0-local-apim/CPtoDP/apim-helm/control-plane/assets
docker build -t wso2am:4.5.0-SNAPSHOT .
```

### Run the Docker Container to Verify
Run the Docker container to confirm it is working correctly:
```bash
docker run wso2am:4.5.0-SNAPSHOT
```

---

## 4. Deploy on Kubernetes with Helm
Run the installation script to deploy APIM-ACP on Kubernetes:
```bash
cd apim-agent/kong/1.3.0-local-apim/CPtoDP
sh install.sh
```