# Release and Automation

This repository is prepared to use the reusable workflows from `slice-soft/ss-pipeline`.

## Release Flow

The local workflow [`.github/workflows/release.yml`](../.github/workflows/release.yml) delegates to `slice-soft/ss-pipeline/.github/workflows/create-release.yml@v0`.

That reusable workflow does two things:

- runs `release-please`
- updates the major tag such as `v0` or `v1` after a release is created

For this repository, the initial manifest is set to `0.0.0` in [`.release-please-manifest.json`](../.release-please-manifest.json). That allows the first real `feat:` release to become `v0.1.0`.

## Terraform Docs Flow

The local workflow [`.github/workflows/tf-docs.yml`](../.github/workflows/tf-docs.yml) delegates to `slice-soft/ss-pipeline/.github/workflows/tf-docs.yml@v0`.

It currently targets:

- `modules/pages`

The reusable workflow expects each managed README to contain these markers:

```md
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

When Terraform inputs or outputs change, the workflow regenerates the reference section and opens a PR instead of pushing directly to `main`.

## Repository Settings

When the GitHub repo is created, ensure these Actions settings are enabled:

- `Allow all actions and reusable workflows`
- `Read and write permissions` for workflows

## Commit Conventions

Releases depend on Conventional Commits:

- `feat:` for minor changes
- `fix:` for patch changes
- `feat!:` for breaking changes
- `docs:`, `chore:`, `ci:` and similar types for non-release changes unless paired with a semver-relevant change
