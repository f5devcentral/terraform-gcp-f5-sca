#!/bin/bash
dir=${PWD}
GCP_PROJECT=$(gcloud config get-value project)
# setup kic
# authorize docker to push custom images
echo "authorize docker to push to Google Container Registry"
gcloud auth configure-docker
# build kic+image for gcp
git clone https://github.com/nginxinc/kubernetes-ingress.git
cd kubernetes-ingress
git checkout tags/v1.9.0
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
make DOCKERFILE=DockerfileForPlus VERSION=v1.9.0 PREFIX=gcr.io/${GCP_PROJECT}/nginx-plus-ingress
cd $dir
# get plus demos
echo "get KIC demos"
# thanks to ALEX!!! alexeadem
git clone https://github.com/vinnie357/nginx-plus-demos.git
# change to demos
cd nginx-plus-demos
# get secrets
echo "get secrets"
secrets=$(gcloud secrets versions access latest --secret="nginx-secret")
# install cert key
echo "setting info from Metadata secret"
# cert
cat << EOF > licenses/nginx-repo.crt
$(echo $secrets | jq -r .cert)
EOF
# key
cat << EOF > licenses/nginx-repo.key
$(echo $secrets | jq -r .key)
EOF
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
clusterNodes=$(gcloud compute instances list --filter "name:demosca*"-clu --format json | jq -r .[].networkInterfaces[].accessConfigs[0].natIP)

# cluster creds
echo "get GKE cluster creds"
gcloud container clusters \
    get-credentials  $clusterName	 \
    --zone $zone

# change to kic
cd nginx-plus-ingress

# modify for custom registry
sed -i "s/nginx-plus-ingress:1.9.0/gcr.io\/${GCP_PROJECT}\/nginx-plus-ingress:v1.9.0/g" k8s/deployments/daemon-set/nginx-plus-ingress.yaml
# setup images
echo "setup kic"
. demo.sh build

# show pods
echo " show ingress pods"
sleep 30
kubectl get pods -n nginx-ingress -o wide
#kubectl logs -f -lapp=nginx-ingress -n nginx-ingress
# finished
cd $dir
echo "done"
