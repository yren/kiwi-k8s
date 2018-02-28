
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
```