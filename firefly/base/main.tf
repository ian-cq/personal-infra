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
  token    = data.onepassword_item.firefly_pat_token.password
  extra_headers = {
    "X-API-Key" = data.onepassword_item.gateway_homelab_auth.password
  }
}
