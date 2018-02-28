#!/bin/bash

if [ -z $env ]; then
  echo "no env, please export env=? first. eg. export env=dev"
  exit 1;
fi

node_count=3
master_count=3
master_size=t2.medium
node_size=t2.medium
region="us-east-1"
vpc_id=vpc-f4845c8f

export S3_BUCKET=${env}-kiwi-k8s-store
export KOPS_STATE_STORE=s3://${S3_BUCKET}
export AWS_AVAILABILITY_ZONES=${region}a,${region}b,${region}c
export AWS_AVAILABILITY_MASTER_ZONES=${region}a,${region}b,${region}c
export CLUSTER_NAME=${env}.kiwi.k8s.local

echo "create s3 bucket ${S3_BUCKET}"
if [ $region == 'us-east-1' ]; then
  aws s3api create-bucket \
  --bucket $S3_BUCKET \
  --region $region
else 
  aws s3api create-bucket \
  --bucket $S3_BUCKET \
  --region $region \
  --create-bucket-configuration LocationConstraint=$region
fi

aws s3api put-bucket-versioning --bucket $S3_BUCKET --versioning-configuration Status=Enabled

echo "region: $region"
echo "AWS_AVAILABILITY_ZONES : $AWS_AVAILABILITY_ZONES"
echo "AWS_AVAILABILITY_MASTER_ZONES : $AWS_AVAILABILITY_MASTER_ZONES"
echo "S3_BUCKET : $S3_BUCKET"
echo "NODE_SIZE : $NODE_SIZE "
echo "CLUSTER_NAME : $CLUSTER_NAME"
echo "node_count: $node_count, node_size: $node_size"
echo "master_count: $master_count, master_size: $master_size"

## output kops yaml to out/ 
kops create cluster ${CLUSTER_NAME} \
--cloud aws \
--node-count ${node_count} \
--master-count ${master_count} \
--state ${KOPS_STATE_STORE} \
--zones=${AWS_AVAILABILITY_ZONES} \
--master-zones=${AWS_AVAILABILITY_MASTER_ZONES} \
--node-size=${node_size} \
--master-size=${master_size} \
--vpc=${vpc_id} \
--topology=private \
--networking=flannel-vxlan \
--master-volume-size 30 \
--node-volume-size 30 \
--dry-run \
-o yaml > out/$CLUSTER_NAME.yaml


echo "cp out/$CLUSTER_NAME.yaml resources/$CLUSTER_NAME.yaml"
