#!/bin/bash

if [ -z $env ]; then
  echo "no env, please export env=? first. eg. export env=dev"
  exit 1;
fi

cf_stackname=BasicVPC
s3_bucket=${env}-kiwi-cloudformation-scripts

aws cloudformation deploy --stack-name ${cf_stackname} --s3-bucket ${s3_bucket} --force-upload --template-file ../cloudformation/update_network_cloudformation.json 

