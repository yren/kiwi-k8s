# AWS network cloudformation for kubernetes cluster

## create a basic VPC with cloudformation (10.35.0.0/24)
```
export env=dev
./update_network_cloudformation.sh
```

## create s3 bucket
```
region='us-east-1'
export env=dev
s3_bucket=${env}-kiwi-cf-scripts
echo "create s3 bucket ${s3_bucket}"

if [ $region == 'us-east-1' ]; then
  aws s3api create-bucket \
  --bucket $s3_bucket \
  --region $region
else 
  aws s3api create-bucket \
  --bucket $s3_bucket \
  --region $region \
  --create-bucket-configuration LocationConstraint=$region
fi
```

## aws cloudformation
```
# update aws cli
pip install awscli --upgrade --user

export env=dev
s3_bucket=${env}-kiwi-cf-scripts
cf_stackname=${env}vpcdemo

aws cloudformation deploy --stack-name ${cf_stackname} \
--s3-bucket ${s3_bucket} --force-upload --template-file \
./vpc_demo.yaml \
--parameter-overrides Env=${env} ClassB=10 \
--no-execute-changeset
* actual run
aws cloudformation deploy --stack-name ${cf_stackname} \
--s3-bucket ${s3_bucket} --force-upload --template-file \
./vpc_demo.yaml \
--parameter-overrides Env=${env} ClassB=10 \
```