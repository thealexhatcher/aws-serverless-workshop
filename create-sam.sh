#!/bin/sh
set -e
echo "$(date +%T)::creating new stack AWS-WORKSHOP-SAM-RELEASE..."
aws cloudformation package --template-file slalom-workshop-repo/sam.yml --output-template-file sam.out.yml --s3-bucket slalom-workshop-bucket
echo "$(date +%T)::creating new stack AWS-WORKSHOP-SAM-RELEASE..."
aws cloudformation deploy --template-file sam.out.yml --stack-name AWS-WORKSHOP-SAM-RELEASE --capabilities CAPABILITY_IAM
echo "$(date +%T)::AWS-WORKSHOP-SAM-RELEASE create completed."
rm sam.out.yml
