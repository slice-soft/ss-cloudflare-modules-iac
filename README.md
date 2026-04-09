# ss-cloudflare-modules-iac

Public Terraform modules for Cloudflare infrastructure shared across SliceSoft projects.

## Status

This repository starts with one stable module:

| Module | Status | Purpose |
| --- | --- | --- |
| [`modules/pages`](modules/pages) | Ready | Cloudflare Pages project with optional custom domain and optional DNS CNAME |

The repository is intentionally small in `v0.x`. New modules should only be added when there is real reuse and a stable contract.

## Why This Repository Exists

Cloudflare infrastructure was already duplicated across multiple SliceSoft repositories. Instead of publishing one repo per resource, this repository groups small and composable Terraform modules by provider family.

That keeps release management simpler:

- one public repo
- one shared version per tag
- several focused modules under `modules/`

## Quick Start

```hcl
module "docs" {
  source = "git::https://github.com/slice-soft/ss-cloudflare-modules-iac.git//modules/pages?ref=v0.1.0"

  account_id      = var.cloudflare_account_id
  project_name    = "ss-keel-docs"
  build_command   = "npm run build"
  destination_dir = "dist"
  zone_id         = var.cloudflare_zone_id
  custom_domain   = "docs.keel-go.dev"
}
```

For module details, use:

- [modules/pages/README.md](modules/pages/README.md)
- [examples/pages-basic/main.tf](examples/pages-basic/main.tf)
- [examples/pages-custom-domain/main.tf](examples/pages-custom-domain/main.tf)

## Documentation

Editorial documentation lives in [docs/](docs/README.md).

- [docs/pages-module.md](docs/pages-module.md)
- [docs/releasing.md](docs/releasing.md)

Terraform reference documentation lives inside each module README and is prepared for automatic updates through the release workflow, which delegates to the reusable `tf-docs.yml` workflow from `ss-pipeline` only after a release is created.

## Automation

This repository is prepared to use reusable workflows from `slice-soft/ss-pipeline`:

- release automation with [`.github/workflows/release.yml`](.github/workflows/release.yml)
- Terraform README generation chained from [`.github/workflows/release.yml`](.github/workflows/release.yml)

The tag flow is based on `release-please` and keeps the major tag such as `v0` updated automatically.

The first module in this repo targets the Cloudflare Terraform provider v5 schema.

## Repository Layout

```text
ss-cloudflare-modules-iac/
├── .github/workflows/
├── docs/
├── examples/
│   ├── pages-basic/
│   └── pages-custom-domain/
├── modules/
│   └── pages/
├── CHANGELOG.md
├── release-please-config.json
├── .release-please-manifest.json
├── README.md
└── LICENSE
```

## Planned Modules

- `modules/d1-database`
- `modules/r2-bucket`
- `modules/dns-record`
- `modules/cache-ruleset`

There is no generic `cdn` module for now. In Cloudflare that concept is too broad and would produce a weak API full of optional flags.

## License

MIT
