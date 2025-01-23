# k8s-infrastructure
This repo contains all resources needed to setup a k8s platform including some useful tools and components, in the manifest format, according to the principles of IaC and GitOps:
* k8s Dashboard configuration
* [API Gateway](https://gateway-api.sigs.k8s.io/) ([nginx implementation](https://docs.nginx.com/nginx-gateway-fabric/)), replacing the Ingress component
* [cert-manager](https://cert-manager.io/) for the https certificates management
* [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) to secure secrets that are stored in this repository
* [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) to keep all configurations in sync
* [keycloak](https://www.keycloak.org/getting-started/getting-started-kube) as identity provider and authorization service for future services, uses postgreSQL as persistence layer
* [postgreSQL](https://bitnami.com/stack/postgresql)

## Prerequisites
1) Install a kubernetes instance: you can use [minikube](https://minikube.sigs.k8s.io/docs/) for your local environment or [kubespray](https://kubespray.io/) for a production-like environment.

## Installation

1) Install [ArgoCD](https://argo-cd.readthedocs.io/en/stable/):
    ```bash
    kubectl kustomize infra/envs/<your-env>/argocd | kubectl apply -f -
    ```
2) To access your services locally, adjust your /etc/hosts file to access the k8s dashboard and the ArgoCD UI:
    ```bash
    echo "$(minikube ip) dashboard.k8s.local argocd.k8s.local" | sudo tee -a /etc/hosts
    ```
3) Retrieve the initial ArgoCD admin password:
    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```
    Note: This is supposed to be a one time use password and it is recommended to change it.

4) login to the ArgoCD UI at [argocd.k8s.local:31598](https://argocd.k8s.local:31598) with the username `admin` and the password retrieved in the previous step.

5) Check the ArgoCD UI and enjoy

## Supported Environments
For now only the `local` environment is supported, but in the future I will add Oracle Cloud Infrastructure (`oci`).

## TLS management
The strategy implemented for the https certificates management is based on the termination of the TLS connection at the API Gateway level (downstream flow). The internal connections between the API Gateway and the services are done over http.
In case of `local` installation, the certificates are self-signed and you will need to trust them in your browser.

## Sealed Secrets
You need to install the client locally to encrypt secrets and have direct access to the k8s cluster:
```bash
   curl -OL "https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.28.0/kubeseal-0.28.0-linux-amd64.tar.gz"
   tar -xvzf kubeseal-0.28.0-linux-amd64.tar.gz kubeseal
   sudo install -m 755 kubeseal /usr/local/bin/kubeseal
```
Alternatively for manjaro users:
```bash
  sudo pacman -S kubeseal
```
