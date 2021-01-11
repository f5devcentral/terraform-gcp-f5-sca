#!/bin/bash
GCP_PROJECT=$(gcloud config get-value project)
# cleanup kic
dir=${PWD}
# change to demos
cd nginx-plus-demos
# change to kic
cd nginx-plus-ingress
# destroy
. demo.sh delete
echo "delete KIC container"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-plus-ingress:v1.9.0"
# finished
cd $dir
rm demo/kic/kubernetes-ingress/nginx-repo.crt
rm demo/kic/kubernetes-ingress/nginx-repo.key
rm demo/kic/nginx-plus-demos/licenses/nginx-repo.crt
rm demo/kic/nginx-plus-demos/licenses/nginx-repo.key
echo "====Done===="
