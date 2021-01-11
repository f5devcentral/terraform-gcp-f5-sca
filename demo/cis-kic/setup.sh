#!/bin/bash
dir=${PWD}
GCP_PROJECT=$(gcloud config get-value project)
# expects sed/gcloud/jq best run in google cloud shell
# bigip
echo -n "Enter your bigip username and press [ENTER]: "
read BIGIP_ADMIN
secrets=$(gcloud secrets versions access latest --secret="bigip-secret")
BIGIP_PASS=$(echo $secrets | jq -r .pass)

echo "get big-ip info"
bigip1ExternalSelfIp=$(gcloud compute instances list --filter "demosca-f5vm01" --format json | jq .[0] | jq .networkInterfaces | jq -r .[0].networkIP)
bigip1ExternalNatIp=$(gcloud compute instances list --filter "demosca-f5vm01" --format json | jq .[0] | jq .networkInterfaces | jq -r .[0].accessConfigs[0].natIP)
bigip1MgmtIp=$(gcloud compute instances list --filter "demosca-f5vm01" --format json | jq .[0] | jq .networkInterfaces | jq -r .[2].networkIP)
# gke
echo "get GKE cluster info"
# cluster name
#gcloud container clusters list --filter "name:demosca*" --format json | jq .[].name
clusterName=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].name)

# zone
#gcloud container clusters list --filter "name:demosca*" --format json | jq .[].zone
zone=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].zone)

# cluster nodes
# gcloud compute instances list --filter "name:demosca*"-clu
# gcloud compute instances list --filter "name:demosca*"-clu --format json | jq .[].networkInterfaces[].accessConfigs[0].natIP
clusterNodesInt=$(gcloud compute instances list --filter "name:gke-demosca*" --format json | jq -r .[].networkInterfaces | jq -r .[0].networkIP)
clusterNodesExt=$(gcloud compute instances list --filter "name:gke-demosca*" --format json | jq -r .[].networkInterfaces[].accessConfigs[0].natIP)

# cluster creds
echo "get GKE cluster creds"
gcloud container clusters \
    get-credentials  $clusterName	 \
    --zone $zone

# container connector
echo "set bigip-mgmtip $bigip1MgmtIp"
# f5-cluster-deployment-src.yaml > f5-cluster-deployment.yaml
cp cis/f5-cluster-deployment-src.yaml cis/f5-cluster-deployment.yaml
sed -i "s/-bigip-mgmt-address-/$bigip1MgmtIp/g" cis/f5-cluster-deployment.yaml
# deploy cis container
kubectl create secret generic bigip-login-kic -n kube-system --from-literal=username="${BIGIP_ADMIN}" --from-literal=password="${BIGIP_PASS}"
kubectl create serviceaccount k8s-bigip-ctlr-kic -n kube-system
kubectl create clusterrolebinding k8s-bigip-ctlr-clusteradmin-kic --clusterrole=cluster-admin --serviceaccount=kube-system:k8s-bigip-ctlr-kic
kubectl create -f cis/f5-cluster-deployment.yaml



# setup kic
# authorize docker to push custom images
echo "authorize docker to push to Google Container Registry"
gcloud auth configure-docker
# build kic+image for gcp
git clone https://github.com/nginxinc/kubernetes-ingress.git
cd kubernetes-ingress
git checkout tags/v1.9.1
# get secrets
echo "get secrets"
secrets=$(gcloud secrets versions access latest --secret="nginx-secret")
# install cert key
echo "setting info from Metadata secret"
# cert
cat << EOF > nginx-repo.crt
$(echo $secrets | jq -r .cert)
EOF
# key
cat << EOF > nginx-repo.key
$(echo $secrets | jq -r .key)
EOF
#cp ../nginx-plus-demos/licenses/nginx-repo.crt ../nginx-plus-demos/licenses/nginx-repo.key ./
echo "build kic container"
# standard
#make DOCKERFILE=DockerfileForPlus VERSION=v1.9.1 PREFIX=gcr.io/${GCP_PROJECT}/nginx-plus-ingress
# with app protect
make DOCKERFILE=appprotect/DockerfileWithAppProtectForPlus VERSION=v1.9.1 PREFIX=gcr.io/${GCP_PROJECT}/nginx-plus-ingress
cd $dir
# modify for custom registry
cp kic/nginx-plus-ingress-src.yaml kic/nginx-plus-ingress.yaml
sed -i "s/nginx-plus-ingress:1.9.1/gcr.io\/${GCP_PROJECT}\/nginx-plus-ingress:v1.9.1/g" kic/nginx-plus-ingress.yaml
# deploy nginx ingress
# namespace
kubectl create ns nginx-ingress
# service account
kubectl apply -f kic/nginx-plus-ingress-sa.yaml
# permissions
kubectl apply -f kic/nginx-plus-ingress-rbac.yaml
# default certificate
kubectl apply -f kic/default-server-secret.yaml
# custom nginx configmap
kubectl apply -f kic/nginx-config.yaml
# ingress deployment
kubectl apply -f kic/nginx-plus-ingress.yaml

# deploy service
kubectl apply -f kic/nginx-ingress.yml

# deploy application ingress
echo "set virtual address"
cp kic/cis-kic-ingress-src.yml kic/cis-kic-ingress.yml
sed -i "s/-external-virtual-address-/$bigip1ExternalSelfIp/g" kic/cis-kic-ingress.yml

kubectl apply -f kic/cis-kic-ingress.yml
# wait for pods
sleep 30
# finished
echo "check app at http://$bigip1ExternalNatIp"
# watch logs
# show ingress pods
kubectl -n nginx-ingress get pods -o wide
echo "type yes to tail the cis logs"
read answer
if [ $answer == "yes" ]; then
    cisPod=$(kubectl get pods -n kube-system -o json | jq -r ".items[].metadata | select(.name | contains (\"k8s-bigip-ctlr-deployment-kic\")).name")
    kubectl logs -f $cisPod -n kube-system | grep --color=auto -i '\[as3'
else
    echo "Finished"
fi

echo "====Done===="
