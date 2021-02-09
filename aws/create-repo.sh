#!/bin/sh
set -e

bucketname="slalom-workshop-bucket"
reponame="slalom-workshop-repo"

echo "[ 
 { \"ParameterKey\":\"BucketName\", \"ParameterValue\":\"${bucketname}\" },
 { \"ParameterKey\":\"RepoName\", \"ParameterValue\":\"${reponame}\" }
]"  > cf-repo.params.json

echo "$(date +%T)::creating new stack AWS-WORKSHOP-REPO..."
aws cloudformation create-stack --stack-name AWS-WORKSHOP-REPO --template-body file://cf-repo.yml --parameters file://cf-repo.params.json --capabilities CAPABILITY_IAM
echo "$(date +%T)::waiting for AWS-WORKSHOP-REPO create to complete..."
aws cloudformation wait stack-create-complete --stack-name AWS-WORKSHOP-REPO
aws cloudformation describe-stacks --stack-name AWS-WORKSHOP-REPO  --query 'Stacks[0].Outputs[]' --output text
echo "$(date +%T)::AWS-WORKSHOP-REPO create completed."
rm cf-repo.params.json

git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
rm -rf $reponame
git clone "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/${reponame}" 
