terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.0"
    }
    fireflyiii = {
      # Self-hosted Terraform Registry at terraform.quanianitis.com,
      # backed by the GCS bucket 'quanianitis-terraform-provider' and
      # fronted by Cloudflare. See the provider repo
      # (github.com/ian-cq/terraform-provider-firefly-iii) for how it
      # is published.
      source  = "terraform.quanianitis.com/ian-cq/firefly-iii"
      version = "~> 0.5"
    }
  }
}
