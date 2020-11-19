# NGINX service mesh

https://docs.nginx.com/nginx-service-mesh/

https://docs.nginx.com/nginx-service-mesh/get-started/introduction/

## downloads

https://downloads.f5.com/

will need a [free account](https://login.f5.com/resource/registerEmail.jsp)

Find a Download -> NGINX-Public -> NGINX_Service_Mesh ->

- nginx-meshctl_linux.gz
- nginx-meshctl_linux.gz.md5
- nginx-mesh-images-0.6.0.tar.gz
- nginx-mesh-images-0.6.0.tar.gz.md5

### verify hash

```bash
# note success is a zero exit ( no standard output)
# ctl
diff  <(md5sum nginx-meshctl_linux.gz ) <(cat nginx-meshctl_linux.gz.md5)
# image
diff  <(md5sum nginx-mesh-images-0.6.0.tar.gz ) <(cat nginx-mesh-images-0.6.0.tar.gz.md5)

```

## install cli

https://docs.nginx.com/nginx-service-mesh/get-started/getting-started-cli/

```bash
#gunzip nginx-meshctl_linux.gz
#sudo mv nginx-meshctl_linux /usr/local/bin/nginx-meshctl
gunzip -c nginx-meshctl_linux.gz | sudo tee /usr/local/bin/nginx-meshctl > /dev/null
sudo chmod +x /usr/local/bin/nginx-meshctl
nginx-meshctl version
```
sudo unzip -o ./nginx-meshctl_linux.gz -d /usr/local/bin/


## private registry
https://docs.nginx.com/nginx-service-mesh/usage/private-registry/

```bash
# unzip
tar zxvf nginx-mesh-images.0.6.0.tar.gz
cd nginx-mesh-images-0.6.0
# load to local docker
for image in $(ls)
do
  docker load < $image
done
# tag images
images="nginx-mesh-api nginx-mesh-metrics nginx-mesh-init nginx-mesh-sidecar"
version="0.6.0"
registry="myregistry"
for image in $images
do
  docker tag $image:$version $registry/$image:$version
done
# push images
for image in $images
  docker push $registry/$image:$version
done
```
## install mesh

https://docs.nginx.com/nginx-service-mesh/get-started/install/

```bash
nginx-meshctl deploy --nginx-mesh-api-image "<your-docker-registry>/nginx-mesh-api:<tag>" \
    --nginx-mesh-sidecar-image "<your-docker-registry>/nginx-mesh-sidecar:<tag>" \
    --nginx-mesh-init-image "<your-docker-registry>/nginx-mesh-init:<tag>" \
    --nginx-mesh-metrics-image "<your-docker-registry>/nginx-mesh-metrics:<tag>"

kubectl -n nginx-mesh get pods

```
