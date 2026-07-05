variable "firefly_base_url" {
  type        = string
  description = "Firefly III API base URL. Public host is X-API-Key-gated at the gateway (see homelab infra/kustomize/gateway/); the terraform-provider-firefly-iii does NOT send X-API-Key today, so overriding this to the in-cluster URL via port-forward (FIREFLYIII_BASE_URL=http://localhost:18080) is required until provider v0.6.0 ships extra_headers."
  default     = "https://firefly.api.quanianitis.com"
}

variable "default_currency" {
  type        = string
  description = "ISO 4217 currency code used as the default for asset and revenue accounts. Firefly forces replacement (destroy + recreate) on account currency changes, so re-denominating destroys history — migrate transactions first."
  default     = "MYR"
}
