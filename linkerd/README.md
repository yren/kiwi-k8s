# Service Mesh

## ref docs
1. [Linkerd](https://github.com/linkerd/linkerd)
2. [A Service Mesh for Kubernetes blog series](https://buoyant.io/2016/10/04/a-service-mesh-for-kubernetes-part-i-top-line-service-metrics/)

## 1. create namespace linkerd 
```
kubectl create namespace linkerd
```

## 2. rbac deploy
```
kubectl apply -f rbac.yml
```

##
```
kubectl apply -f namerd.yml
```