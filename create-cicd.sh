#!/bin/sh
set -e

servicename="AWS-WORKSHOP"
timestamp=$(date +%s)
bucketname="slalom-workshop-bucket"
reponame="slalom-workshop-repo"

echo "[ 
 { \"ParameterKey\":\"ServiceName\", \"ParameterValue\":\"${servicename}\" },
 { \"ParameterKey\":\"BucketName\", \"ParameterValue\":\"${bucketname}\" },
 { \"ParameterKey\":\"RepoName\", \"ParameterValue\":\"${reponame}\" }
]"  > cf-pipeline.params.json

echo "$(date +%T)::creating new stack AWS-WORKSHOP-PIPELINE..."
aws cloudformation create-stack --stack-name AWS-WORKSHOP-PIPELINE --template-body file://cf-pipeline.yml --parameters file://cf-pipeline.params.json --capabilities CAPABILITY_IAM
echo "$(date +%T)::waiting for AWS-WORKSHOP-PIPELINE create to complete..."
aws cloudformation wait stack-create-complete --stack-name AWS-WORKSHOP-PIPELINE
#aws cloudformation describe-stacks --stack-name AWS-WORKSHOP-PIPELINE  --query 'Stacks[0].Outputs[]' --output text
echo "$(date +%T)::AWS-WORKSHOP-PIPELINE create completed."
rm cf-pipeline.params.json



