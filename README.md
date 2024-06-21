# Nodejs-app-deploy
Automated Deployment of a Node.js Application with CI/CD and GitOps

## Project Overview
This project encapsulates a simple Node.js application into a Docker container and automates its deployment using GitHub Actions, Docker Hub, Helm, and Argo CD. The primary aim is to create a seamless pipeline that builds, deploys, and manages the application in a Kubernetes cluster with minimal manual intervention.

## Docker Image on DockerHub
 we use the following Docker image:
- `goswami49ag/node-avi:v0.0.1`

## Clone the repository
To get started with the project, you need to clone the repository to your local machine. Use the following command to clone the repository:
```bash
git clone https://github.com/GOavi101/Nodejs-app-deploy.git
````

## Set Up Any Necessary Configurations
### Helm Chart Configuration Changes
To customize the deployment of the application using Helm, you can modify the `values.yaml` file located in the Helm chart directory `charts\node-avi`. This file allows you to override default settings to better suit your deployment needs. Below are some common configuration options you might want to change:
1. **Replica Count**
    - Adjust the number of pod replicas to ensure the application can handle the desired load.
    ```yaml
    replicaCount: 2
    ```
2. **Image Configuration**
    - Specify the Docker image repository, tag, and pull policy.
    ```yaml
    image:
      repository: goswami49ag/node-avi
      tag: "v0.0.1"
      pullPolicy: IfNotPresent
    ```
3. **Service Configuration**
    - Define the type of service and the port it will expose.
    ```yaml
    service:
      type: ClusterIP
      port: 3000
    ```
### Example `values.yaml` Configuration
Here's an example of a `values.yaml` configuration that you might use:
```yaml
replicaCount: 2

image:
  repository: goswami49ag/node-avi
  tag: "v0.0.1"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 3000
````
### ArgoCD Application Configuration - `node-avi-app.yaml`
This file sets up an ArgoCD application for deploying a NodeJS application using Helm charts.
#### Metadata
Ensure that the namespace is set to the one where ArgoCD is installed.
```yaml
metadata:
  name: node-avi
  namespace: argocd
```
#### Destination
Set the destination to the desired Kubernetes cluster and namespace. Here, we keep the default namespace or any namespace where the application should be deployed, which can be different from the ArgoCD namespace
```yaml
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default # This can be changed to the desired target namespace
```

## Deploying the Application on a Kubernetes Cluster Using ArgoCD
This guide explains how to deploy a NodeJS application on a Kubernetes cluster using ArgoCD by applying the `node-avi-app.yaml` file.
### Prerequisites
- **ArgoCD Installed:** Ensure ArgoCD is installed and running in your Kubernetes cluster.
- **Kubernetes Access:** You must have access to the Kubernetes cluster and have `kubectl` configured to interact with it.
- **Configuration File:** The `node-avi-app.yaml` file should be prepared as described below.
### Apply the Configuration File
Use the kubectl command to apply the node-avi-app.yaml file to your Kubernetes cluster.
```bash
kubectl apply -f node-avi-app.yaml
```

## Testing the Application
After deploying the application, you can test its functionality by following these steps:
### Run a Test Pod:
Use kubectl to run a test pod that will attempt to connect to the application service.
```bash
kubectl -n <namespace> run -i --tty --rm debug --image=curlimages/curl --restart=Never -- curl http://node-avi.<namespace>.svc.cluster.local:3000
```
Replace **namespace** with the namespace where your application is deployed.
### Verify the Output
The command should return **Hello Node!** if the application is running correctly. This indicates that the NodeJS application is successfully deployed and accessible within the cluster.

