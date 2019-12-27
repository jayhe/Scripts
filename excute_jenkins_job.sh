#!/usr/bin/env bash
JENKINSURL='http://10.118.64.65:8080'
JOBNAME='cassec-app-ios'

#curl -Lv http://localhost:8080/login 2>&1 | grep -i 'x-ssh-endpoint'
#< X-SSH-Endpoint: localhost:8080
cd ~/Desktop
java -jar ./jenkins-cli.jar \
-s ${JENKINSURL}  \
build ${JOBNAME} \
-p ENVIRONMENT='demo' \
-p RN_BRANCH='master' \
-p NATIVE_BRANCH='feature/2.2.0' \
-p UPLOAD_PGY='0' \