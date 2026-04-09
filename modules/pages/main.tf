locals {
  create_custom_domain = var.custom_domain != ""
  create_dns_record    = var.zone_id != "" && var.custom_domain != ""
}

# Cloudflare Pages project. Deployments happen outside Terraform, usually with Wrangler in CI.
resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = "main"

  build_config = {
    build_command   = var.build_command
    destination_dir = var.destination_dir
    root_dir        = var.root_dir
  }

  lifecycle {
    # Imported projects may still have Git integration configured.
    # Ignore that block so Terraform does not force destroy and recreate.
    ignore_changes = [source]
  }
}

resource "cloudflare_pages_domain" "this" {
  count = local.create_custom_domain ? 1 : 0

  account_id   = var.account_id
  project_name = cloudflare_pages_project.this.name
  name         = var.custom_domain

  depends_on = [cloudflare_pages_project.this]
}

resource "cloudflare_dns_record" "cname" {
  count = local.create_dns_record ? 1 : 0

  zone_id = var.zone_id
  name    = var.custom_domain
  ttl     = 1
  type    = "CNAME"
  content = cloudflare_pages_project.this.subdomain
  proxied = true

  depends_on = [cloudflare_pages_project.this]
}
