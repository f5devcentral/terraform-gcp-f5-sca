#!/bin/bash
# expects sed/gcloud/jq best run in google cloud shell
# assumes setup has been run
# kic
GCP_PROJECT=$(gcloud config get-value project)
# cleanup kic
dir=${PWD}
# destroy
#. demo.sh delete
# ingress definition
kubectl delete -f kic/cis-kic-ingress.yml
# ingress deployment
kubectl delete -f kic/nginx-plus-ingress.yaml
# service account
kubectl delete -f kic/nginx-plus-ingress-sa.yaml
# permissions
kubectl delete -f kic/nginx-plus-ingress-rbac.yaml
# default certificate
kubectl delete -f kic/default-server-secret.yaml
# custom nginx configmap
kubectl delete -f kic/nginx-config.yaml
# ingress deployment
kubectl delete -f kic/nginx-plus-ingress.yaml
# deploy service
kubectl delete -f kic/nginx-ingress-src.yml
# namespace
kubectl delete ns nginx-ingress

echo "delete KIC container"
gcloud container images delete "gcr.io/${GCP_PROJECT}/nginx-plus-ingress:v1.9.1"
# cis
# cluster name
#gcloud container clusters list --filter "name:demosca*" --format json | jq .[].name
clusterName=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].name)
# zone
#gcloud container clusters list --filter "name:demosca*" --format json | jq .[].zone
zone=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].zone)
# project
project=$(gcloud info --format json | jq -r .config.project)
# cluster creds
gcloud container clusters \
    get-credentials  $clusterName	 \
    --zone $zone
# delete cis
kubectl delete deployment k8s-bigip-ctlr-deployment-kic -n kube-system
kubectl delete clusterrolebinding k8s-bigip-ctlr-clusteradmin-kic
kubectl delete serviceaccount k8s-bigip-ctlr-kic -n kube-system
kubectl delete secret bigip-login-kic -n kube-system

# finished
cd $dir
echo "====Done===="
