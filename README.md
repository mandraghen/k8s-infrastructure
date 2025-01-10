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
3) Check the ArgoCD UI and enjoy
