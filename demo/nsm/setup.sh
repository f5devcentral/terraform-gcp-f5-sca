#!/bin/bash
dir=${PWD}
GCP_PROJECT=$(gcloud config get-value project)
NSM_VERSION="0.6.0"
# authorize docker to push custom images
echo "authorize docker to push to Google Container Registry"
gcloud auth configure-docker
# test media
echo "test media"
diff  <(md5sum nginx-meshctl_linux.gz ) <(cat nginx-meshctl_linux.gz.md5)
diff  <(md5sum nginx-mesh-images-${NSM_VERSION}.tar.gz ) <(cat nginx-mesh-images-${NSM_VERSION}.tar.gz.md5)
# install nsm-cli
echo "install nsm-cli"
gunzip -c nginx-meshctl_linux.gz | sudo tee /usr/local/bin/nginx-meshctl > /dev/null
sudo chmod +x /usr/local/bin/nginx-meshctl
nginx-meshctl version

# unzip
echo "unzip images"
tar zxvf nginx-mesh-images-${NSM_VERSION}.tar.gz
cd nginx-mesh-images-${NSM_VERSION}
# load to local docker
for image in $(ls)
do
  docker load < $image
done
# tag images
images="nginx-mesh-api nginx-mesh-metrics nginx-mesh-init nginx-mesh-sidecar"
version="v${NSM_VERSION}"
registry="gcr.io/${GCP_PROJECT}"
for image in $images
do
  docker tag $image:${NSM_VERSION} $registry/$image:$version
done
# push images to registry
echo "push images to registry"
for image in $images
do
  docker push $registry/$image
done
# gke
echo "get GKE cluster info"
# cluster name
clusterName=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].name)
# zone
zone=$(gcloud container clusters list --filter "name:demosca*" --format json | jq -r .[].zone)
# cluster creds
echo "get GKE cluster creds"
gcloud container clusters \
    get-credentials  $clusterName	 \
    --zone $zone
# deploy service mesh from registry
echo "deploy mesh containers"
nginx-meshctl deploy --nginx-mesh-api-image "${registry}/nginx-mesh-api:${version}" \
    --nginx-mesh-sidecar-image "${registry}/nginx-mesh-sidecar:${version}" \
    --nginx-mesh-init-image "${registry}/nginx-mesh-init:${version}" \
    --nginx-mesh-metrics-image "${registry}/nginx-mesh-metrics:${version}"
echo "get running pods"
sleep 30
kubectl -n nginx-mesh get pods -o wide

cd $dir
echo "====Done===="
