#!/bin/bash

if [[ -z $(aws s3api head-bucket --bucket automate-all-the-things-pi-terraform-state) ]]; then
                echo "bucket exists"
        else
                echo "bucket does not exist or permission is not there to view it."
fi
