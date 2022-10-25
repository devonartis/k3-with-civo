# Query xsmall instance size
data "civo_size" "xsmall" {
    filter {
        key = "type"
        values = ["kubernetes"]
    }

    sort {
        key = "ram"
        direction = "asc"
    }
}

# Create a firewall with rules that will 
# allow access to k3 and ssh to compute
resource "civo_firewall" "my-firewall" {
    name = "default-firewall" 
    create_default_rules = false
    ingress_rule {
      label      = "k8s"
      protocol   = "tcp"
      port_range = "6443"
      cidr       = ["0.0.0.0/0"]
      action     = "allow"
  }

  ingress_rule {
      label      = "ssh"
      protocol   = "tcp"
      port_range = "25"
      cidr       = ["0.0.0.0/0"]
      action     = "allow"
  }

  egress_rule {
    label      = "all"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

}


# Create a cluster
resource "civo_kubernetes_cluster" "my-cluster" {
    region = "NYC1"
    name = "my-cluster"
    applications = "Redis,Linkerd:Linkerd & Jaeger,kube-hunter,kubeclarity,Rancher"
    firewall_id = civo_firewall.my-firewall.id
    pools {
        size = element(data.civo_size.xsmall.sizes, 0).name
        node_count = 3
    }
}