# What is this project?
![Kubernetes Logo](https://kubernetes.io/images/kubernetes-horizontal-color.png)

This repo deploys a fully functioning highly available kubernetes cluster to your AWS account using EC2 instances. 

# Requirements
- BASH shell
- Terraform
- Ansible(Not core, community modules are used)
- An AWS account
- A .cred file in the root of this project directory structure
- Your VPC ID
- Public subnets created and tagged "Tier=public"

## Create a .cred file
export AWS_ACCESS_KEY_ID="<YOUR KEY ID HERE>"<br/>
export AWS_SECRET_ACCESS_KEY="<YOUR SECRET KEY HERE>"<br/>
export AWS_REGION="<YOUR AWS REGION HERE>"<br/>

# Quick Start
All variables are defined in the cluster.bash script. The default values will create a cluster of 3 controlplanes and 3 workers on t2.medium instance types running k8s version 1.23.0. Running this on instances smaller than t2.medium will cause issues during the control plane join phase.

## Clone repo
git clone https://github.com/richardmoran-dev/aws-k8s-cluster.git

## Create cluster
`./cluster.bash create`

## Destroy cluster
`./cluster.bash destroy`
