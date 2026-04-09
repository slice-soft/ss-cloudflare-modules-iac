terraform {
  required_version = ">= 1.5.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.17"
    }
  }
}

provider "cloudflare" {}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID."
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID for the custom domain."
}

module "docs" {
  source = "../../modules/pages"

  account_id      = var.cloudflare_account_id
  project_name    = "ss-keel-docs"
  build_command   = "npm run build"
  destination_dir = "dist"
  zone_id         = var.cloudflare_zone_id
  custom_domain   = "docs.keel-go.dev"
}
