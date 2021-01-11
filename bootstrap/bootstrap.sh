#!/bin/bash

$(aws s3api head-bucket --bucket automate-all-the-things-pi2-terraform-state &>s3.out)

if [[ $(grep -c 404 ./s3.out) -ne 0 ]];
then
        echo "bucket does not exist."
        terraform init
        terraform apply
        cp ./remote_setup/terraformConfig.tf .
        terraform init -force-copy

else
        echo "bucket exists."
fi
