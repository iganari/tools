#!/bin/bash

set -xeu

terraform plan  -var-file=credentials.json
terraform apply -var-file=credentials.json
# -var-file='../hb.tfvars'
