#!/bin/bash
dir=${PWD}
GCP_PROJECT=$(gcloud config get-value project)
NSM_VERSION="0.6.0"

echo "remove mesh"
nginx-meshctl remove

echo "delete images"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-mesh-api:v${NSM_VERSION}"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-mesh-sidecar:v${NSM_VERSION}"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-mesh-init:v${NSM_VERSION}"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-mesh-metrics:v${NSM_VERSION}"

cd $dir
echo "done"
