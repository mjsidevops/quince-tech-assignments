This repository contains the solution/code for one question from each section.

**Section1:** 
-Provisioned the Infrastructure by creating the VPC with 2 private subnets, 2 public subnets, 1 NAT Gateway and IGW. All traffic from public subnet will go to IGW and private subnets will access the internet via NAT gateway.
-Also created an EC2 instance on the Public subnet1, attached with IAM role to access the S3 bucket and also secured with Security group.
Note: This configurations are not executed or tested.

**Section2:**
-Created the Multistage Dockerfile for Java web application. Used given URL to produce source code.

**Section3:**
-Written Python program to "Write a python script to list all S3 buckets which have public access."
-Used boto3 client to interact with AWS 
-The logic is written to check bucket policy status (get_bucket_policy_status) is Public or not for each bucket.
