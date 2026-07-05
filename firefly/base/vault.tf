# quanianitis.com Vault
data "onepassword_vault" "quanianitis_vault" {
  name = "quanianitis.com"
}

# Firefly III Personal Access Token.
#
# Convention (matches cloudflare_api_token_full_write / sendgrid_api_key
# elsewhere in this repo): one dedicated 1Password item per credential,
# with the secret in the item's built-in `password` field.
#
# To create it once:
#   op item create --category=password --vault='quanianitis.com' \
#     --title='firefly_pat_token' \
#     'password=<paste PAT from https://finance.62a.quanianitis.com/profile>'
data "onepassword_item" "firefly_pat_token" {
  vault = data.onepassword_vault.quanianitis_vault.uuid
  title = "firefly_pat_token"
}
