From google/cloud-sdk:latest

RUN apt-get update 
RUN apt-get install -y vim \
                       wget

ADD account.json /opt/account.json
RUN cd /opt && \
       gcloud beta auth activate-service-account test-accout@hb-msp-gcptest.iam.gserviceaccount.com --key-file=account.json

# RUN ls -a /root
ADD bin/chk_ver.sh /opt/
RUN chmod 777 /opt/chk_ver.sh

# ADD update-jenkins-war /opt/gcp
