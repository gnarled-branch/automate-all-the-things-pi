#!/bin/bash

if [[ -z $(aws s3api head-bucket --bucket automate-all-the-things-pi2-terraform-state) ]]; then
                echo "bucket exists"
        else
                echo "bucket does not exist or permission is not there to view it."
                terraform init
                terraform apply
                cp /remote_setup/terraformConfig.tf .
                terraform init -force-copy
fi
