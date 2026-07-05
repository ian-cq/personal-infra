terraform {
  backend "gcs" {
    bucket             = "quanianitis-terraform-state-backend"
    prefix             = "firefly/base"
    kms_encryption_key = "projects/base-430103/locations/asia-southeast1/keyRings/infrastructure/cryptoKeys/terraform-backend"
  }
}

provider "onepassword" {
  account = "my.1password.com"
}

provider "fireflyiii" {
  base_url = var.firefly_base_url
  token    = sensitive(one(flatten([for s in data.onepassword_item.shared_homelab_secrets.section : [for f in s.field : f.value if f.label == "firefly-pat-token"]])))
  extra_headers = {
    "X-API-Key" = sensitive(one(flatten([for s in data.onepassword_item.gateway_homelab_auth.section : [for f in s.field : f.value if f.label == "apikey-gateway"]])))
  }
}
