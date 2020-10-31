# Network module with VPC and subnets

Opinionated terraform module to setup networking in AWS, containing a VPC, public and private networks with an internet gateway.

## Intputs

| Name            | Description                             | Type         | Default  | Required |     |
| --------------- | --------------------------------------- | ------------ | -------- | -------- | --- |
| cidr            | The CIDR block for the VPC.             | string       | `` | yes |
| Name            | Reserved tags for naming resources      | string       | `` | yes |
| private_subnets | List of cidr blocks for private subnets | list(string) | `` | yes |
| public_subnets  | List of cidr blocks for public subnets  | list(string) | `` | yes |
| environment     | Environment name                        | string       | `` | yes |

## Outputs

| Name               | Description                        |
| ------------------ | ---------------------------------- |
| vpc                | Object of VPC created              |
| private_subnet_ids | The list of IDs of private subnets |
| public_subnet_ids  | The list of IDs of public subnets  |
