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

# Firefly III provider.
#
# `base_url` is a variable (defaulted to the public host) so it can be
# overridden with e.g. FIREFLYIII_BASE_URL=http://localhost:18080 when
# running through a `kubectl port-forward svc/firefly 18080:8080`. The
# public host is behind a Google OAuth gate on the gateway that
# short-circuits API calls too; PAT clients must therefore either use
# the port-forward or wait for a bypass rule on the gateway.
#
# `token` comes from the 1Password item declared in vault.tf; the
# item's `password` field must hold the PAT.
provider "fireflyiii" {
  base_url = var.firefly_base_url
  token    = data.onepassword_item.firefly_pat_token.password
}
