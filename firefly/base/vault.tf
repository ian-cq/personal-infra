data "onepassword_vault" "quanianitis_vault" {
  name = "quanianitis.com"
}

data "onepassword_item" "shared_homelab_secrets" {
  vault = data.onepassword_vault.quanianitis_vault.uuid
  title = "shared-homelab-secrets"
}

data "onepassword_item" "gateway_homelab_auth" {
  vault = data.onepassword_vault.quanianitis_vault.uuid
  title = "gateway-homelab-auth"
}
