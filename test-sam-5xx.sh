#!/bin/sh
set -e 

apiid=$(aws cloudformation describe-stacks --stack-name AWS-WORKSHOP-SAM-RELEASE  --query 'Stacks[0].Outputs[?OutputKey==`API`].OutputValue' --output text) 	
resourceid=$(aws apigateway get-resources --rest-api-id $apiid --query 'items[?path==`/resource/{resourceId}`].id' --output text)

echo "PUT..."
aws apigateway test-invoke-method --rest-api-id $apiid --resource-id $resourceid --http-method PUT --body '{"test":"test"}' --path-with-query-string '/resource/'
read -r


