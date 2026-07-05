data "onepassword_vault" "quanianitis_vault" {
  name = "quanianitis.com"
}

data "onepassword_item" "firefly_pat_token" {
  vault = data.onepassword_vault.quanianitis_vault.uuid
  title = "firefly_pat_token"
}

data "onepassword_item" "gateway_homelab_auth" {
  vault = data.onepassword_vault.quanianitis_vault.uuid
  title = "gateway_homelab_auth"
}
