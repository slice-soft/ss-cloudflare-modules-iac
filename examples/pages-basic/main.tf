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

module "landing" {
  source = "../../modules/pages"

  account_id      = var.cloudflare_account_id
  project_name    = "ss-landing-web"
  build_command   = "npm run build"
  destination_dir = "dist"
}
