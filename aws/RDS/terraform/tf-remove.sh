#!/bin/bash

set -xeu

terraform destroy -force -var-file=credentials.json

rm -rfv terraform.tfstate*
