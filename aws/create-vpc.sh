#!/bin/sh
set -e
#CREATE VPC...
aws cloudformation create-stack --stack-name AWS-WORKSHOP-VPC --template-body 'file://cf-vpc.yml'
aws cloudformation wait stack-create-complete --stack-name AWS-WORKSHOP-VPC
