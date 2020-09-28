{
    "class": "Cloud_Failover",
    "environment": "gcp",
    "externalStorage": {
        "scopingTags": {
            "f5_cloud_failover_label": "${bigipCloudFailoverLabel}"
        }
    },
    "failoverAddresses": {
        "enabled": true,
        "scopingTags": {
            "f5_cloud_failover_label": "${bigipCloudFailoverLabel}"
        }
    },
    "failoverRoutes": {
        "enabled": true,
        "scopingTags": {
            "f5_cloud_failover_label": "${bigipCloudFailoverLabel}"
        },
        "scopingAddressRanges": [
            {
                "range": "${managedRoute1}"
            }
        ],
        "defaultNextHopAddresses": {
            "discoveryType": "static",
            "items": [
                "$${local_selfip_ext}",
                "${remote_selfip}"
            ]
        }
    }
  }
