variable "account_id" {
  type        = string
  description = "Cloudflare account ID."
}

variable "project_name" {
  type        = string
  description = "Cloudflare Pages project name (must match the name used in wrangler deploy)."
}

variable "build_command" {
  type        = string
  description = "Command used to build the project."
  default     = "npm run build"
}

variable "destination_dir" {
  type        = string
  description = "Directory where the build output is placed."
  default     = "dist"
}

variable "root_dir" {
  type        = string
  description = "Project root directory relative to the repository root."
  default     = ""
}

variable "zone_id" {
  type        = string
  description = "Cloudflare zone ID for the DNS record. Leave empty to skip DNS management."
  default     = ""

  validation {
    condition     = var.zone_id == "" || var.custom_domain != ""
    error_message = "zone_id requires custom_domain so the module knows which FQDN to create."
  }
}

variable "custom_domain" {
  type        = string
  description = "Full custom domain (for example docs.keel-go.dev). Leave empty to skip."
  default     = ""
}
