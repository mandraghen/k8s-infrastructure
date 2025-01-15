# k8s-infrastructure
This repo contains all resources needed to setup a k8s platform including some useful tools and components, in the manifest format:
* k8s Dashboard configuration
* [API Gateway](https://gateway-api.sigs.k8s.io/) ([nginx implementation](https://docs.nginx.com/nginx-gateway-fabric/)), replacing the Ingress component
* [cert-manager](https://cert-manager.io/) for the https certificates management
* [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) to keep all configurations in sync

according to the principles of IaC and GitOps.

## Prerequisites
1) Install a kubernetes instance: you can use [minikube](https://minikube.sigs.k8s.io/docs/) for your local environment or [kubespray](https://kubespray.io/) for a production-like environment.
2) Install [ArgoCD](https://argo-cd.readthedocs.io/en/stable/):
    ```bash
    kubectl kustomize infra/envs/<your-env>/argocd | kubectl apply -f -
    ```
3) To access your services locally, adjust your /etc/hosts file to access the k8s dashboard and the ArgoCD UI:
    ```bash
    echo "$(minikube ip) dashboard.k8s.local argocd.k8s.local" | sudo tee -a /etc/hosts
    ```
4) Retrieve the initial ArgoCD admin password:
    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```
    Note: This is supposed to be a one time use password and it is recommended to change it.

5) login to the ArgoCD UI at [argocd.k8s.local:31598](https://argocd.k8s.local:31598) with the username `admin` and the password retrieved in the previous step.

6) Check the ArgoCD UI and enjoy

## Supported Environments
For now only the `local` environment is supported, but in the future I will add Oracle Cloud Infrastructure (`oci`).
