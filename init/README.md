# build k8s cluster with kops in AWS

## update aws cli to latest
```
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

##