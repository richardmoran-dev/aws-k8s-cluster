#!/usr/bin/env bash

set -e
source .cred

# The following Terraform environment variables should be set before running the script

export TF_VAR_VPC_ID=${TF_VAR_VPC_ID:="<YOUR VPC ID HERE>"}
export TF_VAR_CLUSTER_NAME=${TF_VAR_CLUSTER_NAME:="demo"}
export TF_VAR_EC2_INSTANCE_TYPE=${TF_VAR_EC2_INSTANCE_TYPE:="t2.medium"}
export TF_VAR_CONTROL_PLANE_COUNT=${TF_VAR_CONTROL_PLANE_COUNT:=3}
export TF_VAR_WORKER_COUNT=${TF_VAR_WORKER_COUNT:=3}

# The following Ansible variables should be set before running the script
KUBERNETES_VERSION=${KUBERNETES_VERSION:=1.23.0}

create() {
    ## Deploy infrastructure with terraform
    cd terraform
    terraform init
    terraform plan -out=tfplan
    terraform apply "tfplan"
    ## Give instances time to be publically available
    sleep 15
    ## Create cluster with ansible
    cd ../ansible
    ansible-playbook cluster.yml -e "KUBERNETES_VERSION=$KUBERNETES_VERSION"
}

destroy() {
    cd terraform
    terraform destroy
}

"$@"