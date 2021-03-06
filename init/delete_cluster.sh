#!/bin/bash

if [ -z $env ]; then
  echo "no env, please export env=? first. eg. export env=dev"
  exit 1;
fi

export S3_BUCKET=${env}-kiwi-k8s-store
export KOPS_STATE_STORE=s3://${S3_BUCKET}
export CLUSTER_NAME=${env}.kiwi.k8s.local
kops delete cluster --name ${CLUSTER_NAME}
kops delete cluster --name ${CLUSTER_NAME} --yes