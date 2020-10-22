# admin
variable adminSourceAddress {
  description = "admin src address in cidr"
}
variable adminAccount {
  description = "admin account"
}
variable adminPassword {
  description = "admin password"
}
# project
variable prefix {
  description = "prefix for resources"
}
variable gcpZone {
  description = "zone where gke is deployed"
}
variable gcpRegion {
  description = "region where gke is deployed"
}
variable gcpProjectId {
  description = "gcp project id"
}
# gke
#https://cloud.google.com/kubernetes-engine/docs/release-notes-regular
#https://cloud.google.com/kubernetes-engine/versioning-and-upgrades
#gcloud container get-server-config --region us-east1
variable gkeVersion {
  description = "GKE release version"
  default     = "1.16.15-gke.1600"
}

variable podCidr {
  description = "k8s pod cidr"
  default     = "10.56.0.0/14"
}

# consul

# nginx
variable nginxKey {
  description = "key for nginxplus"
}
variable nginxCert {
  description = "cert for nginxplus"
}
# controller
variable controllerVersion {
  type        = string
  description = "(optional) Version of controller to install"
  default     = "3.9.0"
}
variable controllerLicense {
  description = "license for controller"
  default     = "none"
}
variable controllerBucket {
  description = "name of controller installer bucket"
  default     = "none"
}
variable controllerAccount {
  description = "name of controller admin account"
  default     = "admin@nginx-gcp.internal"
}
variable controllerPassword {
  description = "pass of controller admin account"
  default     = "admin123!"
}
variable dbPass {
  description = "pass of controller admin account"
  default     = "naaspassword"
}
variable dbUser {
  description = "pass of controller admin account"
  default     = "naas"
}

# bigip

# Variables

# Google Environment
variable serviceAccount {
  description = "machine service account with access to compute api"
}
variable privateKeyId {
  description = "name of existing private key"
}
variable serviceAccountSecretName {
  description = "secret name accessible by service account"
}

# NETWORK
variable extVpc {
  description = "external vpc network"
  default     = "terraform-network-ext-example"
}
variable intVpc {
  description = "internal vpc network"
  default     = "terraform-network-int-example"
}
variable mgmtVpc {
  description = "device management vpc network"
  default     = "terraform-network-mgmt-example"
}
variable extSubnet {
  description = "external vpc subnet range name"
  default     = "ext-sub-example"
}
variable intSubnet {
  description = "internal vpc subnet range name"
  default     = "int-sub-example"
}
variable mgmtSubnet {
  description = "management vpc subnet range name"
  default     = "mgmt-sub-example"
}
variable aliasIpRange {
  description = "alias/secondary IP subnet range"
  default     = "10.0.30.100/32"
}
variable managedRoute1 {
  description = "managed route cidr for cloud failover extension"
  default     = "192.0.2.0/24"
} # adjust to your environment

# BIGIP Image
variable bigipMachineType {
  description = "bigip gce instance size"
  default     = "n1-standard-8"
}
#gcloud compute images list --project f5-7626-networks-public --filter name:payg
variable bigipImageName {
  description = "default gce bigip image name"
  default     = "projects/f5-7626-networks-public/global/images/f5-bigip-15-1-0-4-0-0-6-payg-best-1gbps-200618231635"
}
variable bigipCustomImageName {
  description = "path to custom gce bigip image"
  default     = ""
}
variable customUserData {
  description = "body of custom bigip userdata"
  default     = ""
}

# BIGIP Setup
variable bigipUsername {
  description = "adminstrative account for bigip access name"
}
variable bigipSecret {
  description = "name of google secrets manager secret where bigip credentials are stored"
}
variable license1 {
  description = "body of bigip license key when using BYOL"
  default     = ""
}
variable license2 {
  description = "body of bigip license key when using BYOL"
  default     = ""
}
variable gceSshPublicKey {
  description = "body of bigip ssh public key used to access instances"
}
variable bigipHost1Name {
  description = "hostname of first bigip device"
  default     = "f5vm01"
}
variable bigipHost2Name {
  description = "hostname of second bigip device"
  default     = "f5vm02"
}
variable dnsServer {
  description = "address of addtionale dns server for bigip devices"
  default     = "8.8.8.8"
}
variable dnsSuffix {
  description = "dns suffix for bigip devices often your .c.yourproject"
}
variable ntpServer {
  description = "address of  bigip reachable ntp servers"
  default     = "0.us.pool.ntp.org"
}
variable timezone {
  description = "default timezome for bigip devices"
  default     = "UTC"
}
variable doUrl {
  description = "path to declarative onboarding rpm"
  default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.14.0/f5-declarative-onboarding-1.14.0-1.noarch.rpm"
}
variable as3Url {
  description = "path to application services 3 rpm"
  default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.21.0/f5-appsvcs-3.21.0-4.noarch.rpm"
}
variable tsUrl {
  description = "path to telemetry streaming rpm"
  default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.13.0/f5-telemetry-1.13.0-2.noarch.rpm"
}
variable cfUrl {
  description = "path to cloud failover rpm"
  default     = "https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v1.4.0/f5-cloud-failover-1.4.0-0.noarch.rpm"
}
variable bigipOnboardLog {
  description = "path to bigip onboarding logs"
  default     = "/var/log/cloud/onboard.log"
}

# BIGIQ License Manager Setup
variable bigIqHost {
  description = "ip address of bigiq license manager"
  default     = ""
}
variable bigIqUsername {
  description = "user name for bigiq license manager"
  default     = ""
}
variable bigIqSecret {
  description = "name of google secrets manager secret with bigiq password"
  default     = ""
}
variable bigIqLicenseType {
  description = "type of bigiq license when using a license manager"
  default     = ""
}
variable bigIqLicensePool {
  description = "name of bigiq license pool"
  default     = ""
}
variable bigIqSkuKeyword1 {
  description = "sku type name for bigiq license pool"
  default     = ""
}
variable bigIqSkuKeyword2 {
  description = "addtional sku type name for bigiq license pool"
  default     = ""
}
variable bigIqUnitOfMeasure {
  description = "unit of measure for bigiq license pool ( hourly|monthly|yearly)"
  default     = ""
}
variable bigIqHypervisor {
  description = "hypervisor type when sending request to license manager"
  default     = "gce"
}

# TAGS
variable purpose {
  description = "tag for resources"
  default     = "public"
}
variable environment {
  description = "tag for resources ex. dev/staging/prod"
  default     = "f5env"
}
variable owner {
  description = "tag for resources"
  default     = "f5owner"
}
variable group {
  description = "tag for resources"
  default     = "f5group"
}
variable costcenter {
  description = "tag for resources"
  default     = "f5costcenter"
}
variable application {
  description = "application tag for resources"
  default     = "f5app"
}
variable bigipCloudFailoverLabel {
  description = "tag for resources managed by cloud failover extension"
  default     = "mydeployment"
}
