# Google Cloud Platform Secure Cloud Architecture

## Overview
Secure Cloud Architecture in Google Cloud Platform using F5 technologies

- High avaliabilty pair of BIG-IP
  - Failover via API
  - LTM,ASM,AFM
- Nginx Plus
  - App Protect
- Nginx Controller
- Consul
  - service discovery
  - nginx templating
- NGINX KIC
  - ingress
- GKE
## Setup

### Requirements
- storage bucket with controller tarball

    eg: controller-installer-3.7.0.tar.gz

- Controller
  - license file

    [trial license](https://www.nginx.com/free-trial-request-nginx-controller/)

- Nginx plus
  - cert
  - key

    [trial keys](https://www.nginx.com/free-trial-request/)

### Prep

copy admin tfvars example to your own and update with your license keys

```bash
mv admin.auto.tfvars.example admin.auto.tfvars
```

update:
  - project
    - prefix
    - gcpProjectId
    - adminSourceAddress
    - gceSshPublicKey
  - nginx
    - nginxKey
    - nginxCert
    - controllerBucket
    - controllerLicense
  - bigip
    - bigipSecret
    - dnsSuffix
    - serviceAccount

## Getting Started
Provide a quick example of how to use your code.  This should provide the user with a launch point to quickly see what the project can offer them.

## Installation
Outline the requirements and steps to install this project.

## Usage
Outline how the user can use your project and the various features the project offers.

## Variables
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| adminAccount | admin account | `any` | n/a | yes |
| adminPassword | admin password | `any` | n/a | yes |
| adminSourceAddress | admin src address in cidr | `any` | n/a | yes |
| alias\_ip\_range | n/a | `string` | `"10.0.30.100/32"` | no |
| application | n/a | `string` | `"f5app"` | no |
| as3Url | n/a | `string` | `"https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.21.0/f5-appsvcs-3.21.0-4.noarch.rpm"` | no |
| bigIqHost | BIGIQ License Manager Setup | `string` | `""` | no |
| bigIqHypervisor | n/a | `string` | `"gce"` | no |
| bigIqLicensePool | n/a | `string` | `""` | no |
| bigIqLicenseType | n/a | `string` | `""` | no |
| bigIqSecret | n/a | `string` | `""` | no |
| bigIqSkuKeyword1 | n/a | `string` | `""` | no |
| bigIqSkuKeyword2 | n/a | `string` | `""` | no |
| bigIqUnitOfMeasure | n/a | `string` | `""` | no |
| bigIqUsername | n/a | `string` | `""` | no |
| bigipCloudFailoverLabel | n/a | `string` | `"mydeployment"` | no |
| bigipHost1Name | n/a | `string` | `"f5vm01"` | no |
| bigipHost2Name | n/a | `string` | `"f5vm02"` | no |
| bigipMachineType | BIGIP Image | `string` | `"n1-standard-8"` | no |
| bigipOnboardLog | n/a | `string` | `"/var/log/cloud/onboard.log"` | no |
| bigipSecret | n/a | `any` | n/a | yes |
| bigipUsername | BIGIP Setup | `any` | n/a | yes |
| cfUrl | n/a | `string` | `"https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v1.4.0/f5-cloud-failover-1.4.0-0.noarch.rpm"` | no |
| controllerAccount | name of controller admin account | `string` | `"admin@nginx-gcp.internal"` | no |
| controllerBucket | name of controller installer bucket | `string` | `"none"` | no |
| controllerLicense | license for controller | `string` | `"none"` | no |
| controllerPassword | pass of controller admin account | `string` | `"admin123!"` | no |
| controllerVersion | (optional) Version of controller to install | `string` | `"3.9.0"` | no |
| costcenter | n/a | `string` | `"f5costcenter"` | no |
| customImage | n/a | `string` | `""` | no |
| customUserData | n/a | `string` | `""` | no |
| dbPass | pass of controller admin account | `string` | `"naaspassword"` | no |
| dbUser | pass of controller admin account | `string` | `"naas"` | no |
| dnsServer | n/a | `string` | `"8.8.8.8"` | no |
| dnsSuffix | n/a | `any` | n/a | yes |
| doUrl | n/a | `string` | `"https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.14.0/f5-declarative-onboarding-1.14.0-1.noarch.rpm"` | no |
| environment | n/a | `string` | `"f5env"` | no |
| extSubnet | n/a | `string` | `"ext-sub-example"` | no |
| extVpc | NETWORK | `string` | `"terraform-network-ext-example"` | no |
| gceSshPublicKey | n/a | `any` | n/a | yes |
| gcpProjectId | gcp project id | `any` | n/a | yes |
| gcpRegion | region where gke is deployed | `any` | n/a | yes |
| gcpZone | zone where gke is deployed | `any` | n/a | yes |
| gkeVersion | gke https://cloud.google.com/kubernetes-engine/docs/release-notes-regular https://cloud.google.com/kubernetes-engine/versioning-and-upgrades gcloud container get-server-config --region us-east1 | `string` | `"1.16.13-gke.1"` | no |
| group | n/a | `string` | `"f5group"` | no |
| image\_name | gcloud compute images list --project f5-7626-networks-public --filter name:payg | `string` | `"projects/f5-7626-networks-public/global/images/f5-bigip-15-1-0-4-0-0-6-payg-best-1gbps-200618231635"` | no |
| intSubnet | n/a | `string` | `"int-sub-example"` | no |
| intVpc | n/a | `string` | `"terraform-network-int-example"` | no |
| license1 | n/a | `string` | `""` | no |
| license2 | n/a | `string` | `""` | no |
| managed\_route1 | n/a | `string` | `"192.0.2.0/24"` | no |
| mgmtSubnet | n/a | `string` | `"mgmt-sub-example"` | no |
| mgmtVpc | n/a | `string` | `"terraform-network-mgmt-example"` | no |
| nginxCert | cert for nginxplus | `any` | n/a | yes |
| nginxKey | key for nginxplus | `any` | n/a | yes |
| ntpServer | n/a | `string` | `"0.us.pool.ntp.org"` | no |
| owner | n/a | `string` | `"f5owner"` | no |
| podCidr | k8s pod cidr | `string` | `"10.56.0.0/14"` | no |
| prefix | prefix for resources | `any` | n/a | yes |
| privateKeyId | n/a | `any` | n/a | yes |
| purpose | TAGS | `string` | `"public"` | no |
| serviceAccount | Google Environment | `any` | n/a | yes |
| serviceAccountSecretName | n/a | `any` | n/a | yes |
| timezone | n/a | `string` | `"UTC"` | no |
| tsUrl | n/a | `string` | `"https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.13.0/f5-telemetry-1.13.0-2.noarch.rpm"` | no |

## Outputs

| Name | Description |
|------|-------------|
| f5vm01\_mgmt\_pip | Outputs bigip output "f5vm01\_ext\_selfip" { value = google\_compute\_instance.f5vm01.network\_interface.0.network\_ip } output "f5vm01\_ext\_selfip\_pip" { value = google\_compute\_instance.f5vm01.network\_interface.0.access\_config.0.nat\_ip } output "f5vm01\_mgmt\_ip" { value = google\_compute\_instance.f5vm01.network\_interface.1.network\_ip } |
| f5vm01\_mgmt\_pip\_url | n/a |
| f5vm02\_mgmt\_pip | output "f5vm01\_mgmt\_name" { value = google\_compute\_instance.f5vm01.name } output "f5vm02\_ext\_selfip" { value = google\_compute\_instance.f5vm02.network\_interface.0.network\_ip } output "f5vm02\_ext\_selfip\_pip" { value = google\_compute\_instance.f5vm02.network\_interface.0.access\_config.0.nat\_ip } output "f5vm02\_mgmt\_ip" { value = google\_compute\_instance.f5vm02.network\_interface.1.network\_ip } |
| f5vm02\_mgmt\_pip\_url | n/a |
| public\_vip | output "f5vm02\_mgmt\_name" { value = google\_compute\_instance.f5vm02.name } |
| public\_vip\_url | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Running

- login to terraform cloud account if using remote state
    https://www.terraform.io/docs/commands/login.html

  ```bash
  terraform login
  ```
- login to google account

  ```bash
    gcloud auth application-default login
    project="my-project"
    gcloud config set project $project
  ```
- run with script or manual

  ```bash
  . demo.sh
  ```
## Development
Outline any requirements to setup a development environment if someone would like to contribute.  You may also link to another file for this information.

  ```bash
  # test pre commit manually
  pre-commit run -a -v
  ```
## Support
For support, please open a GitHub issue.  Note, the code in this repository is community supported and is not supported by F5 Networks.  For a complete list of supported projects please reference [SUPPORT.md](support.md).

## Community Code of Conduct
Please refer to the [F5 DevCentral Community Code of Conduct](code_of_conduct.md).


## License
[Apache License 2.0](LICENSE)

## Copyright
Copyright 2014-2020 F5 Networks Inc.


### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.
