#!/bin/bash
if [ -z $env ]; then
  echo "no env, please export env=? first. eg. export env=dev"
  exit 1;
fi

export S3_BUCKET=${env}-kiwi-k8s-store
export REPO_NAME=${env}-kiwi-helm-repo

version=`curl -s https://api.github.com/repos/kubernetes/helm/releases/latest | grep tag_name | cut -d '"' -f 4`
helm_tarball="helm-${version}-linux-amd64.tar.gz"
echo "helm version: ${version}"
echo "helm tarball: ${helm_tarball}"
wget -O  ${helm_tarball} https://kubernetes-helm.storage.googleapis.com/${helm_tarball}

tar -zxvf ${helm_tarball}
sudo mv linux-amd64/helm /usr/local/bin/helm
echo "init helm ..."
helm init