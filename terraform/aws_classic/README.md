# nginx default infrastructure

- create VPC
- create subnets in different availability zones
- create Security Group
- create Internet Gateway
- create 2 EC2 in different subnets
- setup Nginx on 80 port
- setup LoadBalancer on port 80

It works in any region
Change region in variables.tf to yours