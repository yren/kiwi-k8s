
# build k8s cluster with kops in AWS

## update aws cli to latest
```
export env=dev

aws --version
pip install awscli --upgrade --user
aws --version
```

## install kops and kubectl
on jumpbox
```
cd kiwi-k8s/init
./install_cli.sh
```
## generate kops yaml
* generate public key for ec2-user
```
ssh-keygen -t rsa -C "ec2-user@kiwi"
```

```
cd kiwi-k8s/init
./export_cluster.sh
./update_cluster.sh

# validate cluster
kops validate cluster
```

## install k8s dashboard
```
cd kiwi-k8s/init
./install_dashboard.sh
```
* dashboard url
```
/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
```

## install helm
```
cd kiwi-k8s/init
./install_helm.sh
```

## delete k8s cluster
* for save money, delete your k8s cluster from AWS (or you may receive a big bill)

```
cd kiwi-k8s/init
export env=dev
./delete_cluster.sh
```