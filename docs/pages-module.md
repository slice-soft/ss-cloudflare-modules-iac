# Pages Module

`modules/pages` is the first public module in this repository because it already exists in more than one internal infrastructure repo and the contract is stable.

## What It Manages

- a `cloudflare_pages_project`
- an optional `cloudflare_pages_domain`
- an optional proxied `cloudflare_dns_record` CNAME that points the hostname to the Pages subdomain

## Why Custom Domain Stays Inside `pages`

For this repository, a separate `cdn` module would be too broad. In Cloudflare, "CDN" can mean cache rules, redirects, custom hostnames, WAF, origin rules, and more. The current need is narrower: provision a Pages project and optionally wire its domain.

That is why the module keeps these related concerns together:

- create the Pages project
- attach the custom domain when needed
- create the DNS record using the full `custom_domain` when the zone is managed in the same account

## Usage Patterns

### Basic project

Use the example in [examples/pages-basic/main.tf](../examples/pages-basic/main.tf) when the Pages project exists without a custom domain managed by this module.

### Project with custom domain

Use the example in [examples/pages-custom-domain/main.tf](../examples/pages-custom-domain/main.tf) when the module should also attach `cloudflare_pages_domain` and create the CNAME in the target zone.

## Operational Notes

- Deployments are expected to happen outside Terraform, usually with Wrangler in CI.
- Imported Pages projects may still have Git integration configured in Cloudflare. The module ignores that block to avoid a forced recreation.
- The module also ignores `build_config` drift after creation/import because Cloudflare provider v5 may expose computed web analytics fields there and then reject the corresponding PATCH request.
- DNS management is optional. If `zone_id` is omitted, the module still creates the Pages project.
- In Cloudflare provider v5, the DNS resource expects the full record name, so this module reuses `custom_domain` as the managed record FQDN.
