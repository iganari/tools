#!/bin/bash

set -exu

gcloud beta auth activate-service-account test-accout@hb-msp-gcptest.iam.gserviceaccount.com --key-file=account.json
gcloud beta container get-server-config --project hb-msp-gcptest --zone asia-northeast1-b
gcloud beta container clusters list --project hb-msp-gcptest
