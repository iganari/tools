#!/bin/bash

set -exu

AC='test-accout@hb-msp-gcptest.iam.gserviceaccount.com'
PJ='hb-msp-gcptest'
ZN='asia-northeast1-b'

cl='wp-platform-prd-hb'


### これは必須
gcloud beta auth activate-service-account ${AC} --key-file=account.json

### zoneのデフォルトのクラスタのversionをチェック
gcloud beta container get-server-config --project ${PJ} --zone ${ZN} | grep defaultClusterVersion

### MASTER VERSION
echo "master version"
gcloud beta container clusters list --project ${PJ} | grep ${cl} | awk '{print $3}'

### NODE VERSION
echo "node version"
gcloud beta container clusters list --project ${PJ} | grep ${cl} | awk '{print $6}'
