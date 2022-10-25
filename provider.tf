terraform {
  required_providers {
    civo = {
      source = "civo/civo"
      version = "1.0.25"
    }
  }
}

provider "civo" {
  # Configuration options
  region = "NYC1"
  token = var.token
}
