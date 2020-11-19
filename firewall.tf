# firewall
# mgmt
resource google_compute_firewall mgmt {
  name    = "${var.prefix}mgmt-firewall-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_mgmt.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "80"]
  }

  source_ranges = var.adminSourceAddress
}
# consul debug
resource google_compute_firewall consul {
  name    = "${var.prefix}consul-firewall-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_int.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8500"]
  }

  source_ranges = var.adminSourceAddress
}
# controller debug
resource google_compute_firewall controller {
  name    = "${var.prefix}controller-firewall-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_int.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }

  source_ranges = var.adminSourceAddress
}
resource google_compute_firewall iap-ingress {
  name    = "${var.prefix}-iap-firewall-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_int.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "80"]
  }

  source_ranges = ["35.235.240.0/20"]
}

# bigip
resource google_compute_firewall default-allow-internal-mgmt {
  name    = "${var.prefix}-default-allow-internal-mgmt-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_mgmt.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["10.0.10.0/24"]
}
resource google_compute_firewall default-allow-internal-ext {
  name    = "${var.prefix}-default-allow-internal-ext-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_ext.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["10.0.30.0/24"]
}
resource google_compute_firewall default-allow-internal-int {
  name    = "${var.prefix}-default-allow-internal-int-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_int.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["10.0.20.0/24"]
}
resource google_compute_firewall allow-internal-egress {
  name      = "${var.prefix}-allow-internal-egress-${random_pet.buildSuffix.id}"
  network   = google_compute_network.vpc_network_int.name
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  priority = "65533"

  destination_ranges = ["10.0.20.0/24"]
}

resource google_compute_firewall app {
  name    = "${var.prefix}-app-vpn-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_ext.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.adminSourceAddress
}

resource google_compute_firewall allow-internal-cis {
  name    = "${var.prefix}-allow-internal-cis-${random_pet.buildSuffix.id}"
  network = google_compute_network.vpc_network_int.name
  #https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
  #enable_logging = true
  log_config {
    #metadata = "INCLUDE_ALL_METADATA"
    metadata = "EXCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65532"

  source_ranges = [google_container_cluster.primary.ip_allocation_policy.0.cluster_ipv4_cidr_block]
}
