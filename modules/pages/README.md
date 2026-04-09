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
- The module also ignores `build_config` updates after creation/import. Cloudflare provider v5 can derive computed analytics fields in that block and then fail the PATCH request with `400/8000006`.

## Terraform Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5.17 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5.17 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.cname](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_pages_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/pages_domain) | resource |
| [cloudflare_pages_project.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/pages_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare account ID. | `string` | n/a | yes |
| <a name="input_build_command"></a> [build\_command](#input\_build\_command) | Command used to build the project. | `string` | `"npm run build"` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | Full custom domain (for example docs.keel-go.dev). Leave empty to skip. | `string` | `""` | no |
| <a name="input_destination_dir"></a> [destination\_dir](#input\_destination\_dir) | Directory where the build output is placed. | `string` | `"dist"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Cloudflare Pages project name (must match the name used in wrangler deploy). | `string` | n/a | yes |
| <a name="input_root_dir"></a> [root\_dir](#input\_root\_dir) | Project root directory relative to the repository root. | `string` | `""` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Cloudflare zone ID for the DNS record. Leave empty to skip DNS management. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_domain"></a> [custom\_domain](#output\_custom\_domain) | Configured custom domain when enabled. |
| <a name="output_dns_record_name"></a> [dns\_record\_name](#output\_dns\_record\_name) | Managed DNS record FQDN when enabled. |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Cloudflare Pages project name. |
| <a name="output_subdomain"></a> [subdomain](#output\_subdomain) | Default Pages subdomain (for example project.pages.dev). |
<!-- END_TF_DOCS -->
