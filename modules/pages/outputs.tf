output "project_name" {
  value       = cloudflare_pages_project.this.name
  description = "Cloudflare Pages project name."
}

output "subdomain" {
  value       = cloudflare_pages_project.this.subdomain
  description = "Default Pages subdomain (for example project.pages.dev)."
}

output "custom_domain" {
  value       = try(cloudflare_pages_domain.this[0].name, null)
  description = "Configured custom domain when enabled."
}

output "dns_record_name" {
  value       = try(cloudflare_dns_record.cname[0].name, null)
  description = "Managed DNS record FQDN when enabled."
}
