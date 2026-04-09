# pages

Creates a Cloudflare Pages project and, when requested, wires a custom domain and its DNS record.

## What This Module Covers

- `cloudflare_pages_project`
- optional `cloudflare_pages_domain`
- optional proxied `cloudflare_dns_record` CNAME that targets the Pages subdomain

This module keeps the domain attachment flow inside `pages` because that behavior is tightly coupled to the Pages project itself. A separate generic `cdn` module would be too broad for the current scope of this repository.

## Example

```hcl
module "landing" {
  source = "git::https://github.com/slice-soft/ss-cloudflare-modules-iac.git//modules/pages?ref=v0.1.0"

  account_id      = var.cloudflare_account_id
  project_name    = "ss-landing-web"
  build_command   = "npm run build"
  destination_dir = "dist"
  zone_id         = var.cloudflare_zone_id
  custom_domain   = "www.slicesoft.dev"
}
```

## Notes

- Deployments are expected to happen outside Terraform, typically with Wrangler in CI.
- If `custom_domain` is empty, the module only creates the Pages project.
- If `zone_id` is empty, DNS management is skipped.
- When DNS is managed, the module uses `custom_domain` as the record FQDN for Cloudflare v5 compatibility.
- Imported Pages projects may still have Git integration in Cloudflare. The module ignores that block to avoid forced recreation.

## Terraform Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| --- | --- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement_cloudflare) | ~> 5.17 |

## Providers

| Name | Version |
| --- | --- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider_cloudflare) | ~> 5.17 |

## Resources

| Name | Type |
| --- | --- |
| [cloudflare_dns_record.cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_pages_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/pages_domain) | resource |
| [cloudflare_pages_project.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/pages_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | --- |
| <a name="input_account_id"></a> [account_id](#input_account_id) | Cloudflare account ID. | `string` | n/a | yes |
| <a name="input_build_command"></a> [build_command](#input_build_command) | Command used to build the project. | `string` | `"npm run build"` | no |
| <a name="input_custom_domain"></a> [custom_domain](#input_custom_domain) | Full custom domain (for example docs.keel-go.dev). Leave empty to skip. | `string` | `""` | no |
| <a name="input_destination_dir"></a> [destination_dir](#input_destination_dir) | Directory where the build output is placed. | `string` | `"dist"` | no |
| <a name="input_project_name"></a> [project_name](#input_project_name) | Cloudflare Pages project name (must match the name used in wrangler deploy). | `string` | n/a | yes |
| <a name="input_root_dir"></a> [root_dir](#input_root_dir) | Project root directory relative to the repository root. | `string` | `""` | no |
| <a name="input_zone_id"></a> [zone_id](#input_zone_id) | Cloudflare zone ID for the DNS record. Leave empty to skip DNS management. | `string` | `""` | no |

## Outputs

| Name | Description |
| --- | --- |
| <a name="output_custom_domain"></a> [custom_domain](#output_custom_domain) | Configured custom domain when enabled. |
| <a name="output_dns_record_name"></a> [dns_record_name](#output_dns_record_name) | Managed DNS record FQDN when enabled. |
| <a name="output_project_name"></a> [project_name](#output_project_name) | Cloudflare Pages project name. |
| <a name="output_subdomain"></a> [subdomain](#output_subdomain) | Default Pages subdomain (for example project.pages.dev). |
<!-- END_TF_DOCS -->
