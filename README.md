# OpenAI Chatbot Infrastructure

This Terraform project deploys a serverless OpenAI chatbot on AWS using Lambda and API Gateway.

## Architecture

- **AWS Lambda**: Runs the Node.js chatbot code
- **API Gateway**: HTTP API endpoint for the chatbot
- **CloudWatch**: Logging and monitoring
- **IAM**: Proper roles and permissions

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform >= 1.0 installed
3. OpenAI API key

## Setup

1. Clone this repository
2. Copy `terraform.tfvars.example` to `terraform.tfvars`
3. Fill in your OpenAI API key in `terraform.tfvars`
4. Create your Lambda function code in the `lambda/` directory

## Deployment

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the changes
terraform apply
```

## Lambda Function Structure

Create a `lambda/` directory with your Node.js code. Example structure:

```
lambda/
├── index.js
├── package.json
└── node_modules/
```

## Security Features

- OpenAI API key is stored as a sensitive variable
- Proper IAM roles with minimal permissions
- CloudWatch logging enabled
- CORS configured for web access

## Monitoring

- Lambda logs: `/aws/lambda/openai-chatbot-function`
- API Gateway logs: `/aws/lambda/openai-chatbot-api`

## Cleanup

```bash
terraform destroy
```

## Cost Optimization

- Lambda timeout set to 30 seconds
- CloudWatch logs retention set to 7 days
- Memory allocation optimized for Node.js runtime
