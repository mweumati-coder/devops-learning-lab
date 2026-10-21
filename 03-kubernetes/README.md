# 03 - Kubernetes manifests

Deploys the app from project 01 plus Redis onto a local cluster.

## What you will learn

- Namespaces, Deployments, Services, ConfigMaps
- Readiness vs liveness probes
- Resource requests and limits
- Rolling updates with zero downtime
- Horizontal Pod Autoscaling

## Setup with kind

```bash
kind create cluster --name lab
# Option A: use the image published by project 02
#   edit deployment.yaml and replace YOUR_GITHUB_USERNAME
# Option B: use a local image
docker build -t lab-app:1.0 ../01-docker-flask-app
kind load docker-image lab-app:1.0 --name lab
#   then set `image: lab-app:1.0` in deployment.yaml
```

## Deploy

```bash
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml -f redis.yaml -f deployment.yaml -f service.yaml
kubectl -n lab get pods -w
kubectl -n lab port-forward svc/lab-app 8080:80
curl localhost:8080/
```

The HPA needs metrics-server, which kind does not ship by default. Install it before applying `hpa.yaml`.

## Useful commands

```bash
kubectl -n lab describe pod <pod>
kubectl -n lab logs deploy/lab-app
kubectl -n lab rollout status deploy/lab-app
kubectl -n lab rollout undo deploy/lab-app
kubectl -n lab scale deploy/lab-app --replicas=4
```

## Exercises

1. Delete a pod and watch Kubernetes replace it. Why did traffic keep flowing?
2. Change `APP_VERSION` in the ConfigMap. Does the app pick it up? What do you need to do?
3. Break the readiness probe path and observe the rollout stall instead of taking the app down.
4. Lower the memory limit to `10Mi` and watch what happens (`OOMKilled`).
5. Convert these manifests into a Helm chart or a Kustomize overlay with `dev` and `prod` variants.
6. Add an Ingress and reach the app by hostname.
