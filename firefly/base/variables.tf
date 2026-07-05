variable "firefly_base_url" {
  type        = string
  description = "Firefly III API base URL. Override with FIREFLYIII_BASE_URL / -var when tunnelling through kubectl port-forward."
  default     = "https://finance.62a.quanianitis.com"
}

# Default currency for all accounts + budget limits declared in this
# module. Change here to re-denominate every asset/revenue account at
# once (Firefly forces replacement on currency changes; plan carefully).
variable "default_currency" {
  type        = string
  description = "ISO 4217 currency code used as the default for asset and revenue accounts."
  default     = "MYR"
}
