#!/bin/sh
set -e

apiid=$(aws cloudformation describe-stacks --stack-name AWS-WORKSHOP-CICD-RELEASE  --query 'Stacks[0].Outputs[?OutputKey==`API`].OutputValue' --output text) 	
resourceid=$(aws apigateway get-resources --rest-api-id $apiid --query 'items[?path==`/resource/{resourceId}`].id' --output text)
echo "PUT..."
aws apigateway test-invoke-method --rest-api-id $apiid --resource-id $resourceid --http-method PUT --body '{"test":"test"}'
read -r

echo "GET..."
aws apigateway test-invoke-method --rest-api-id $apiid --resource-id $resourceid --http-method GET
read -r

echo "DELETE..."
aws apigateway test-invoke-method --rest-api-id $apiid --resource-id $resourceid --http-method DELETE
read -r

