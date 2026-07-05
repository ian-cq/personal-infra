terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.0"
    }
    fireflyiii = {
      source  = "terraform.quanianitis.com/ian-cq/firefly-iii"
      version = "~> 0.5, >= 0.5.3"
    }
  }
}
