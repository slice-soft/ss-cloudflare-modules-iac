# Release and Automation

This repository is prepared to use the reusable workflows from `slice-soft/ss-pipeline`.

## Release Flow

The local workflow [`.github/workflows/release.yml`](../.github/workflows/release.yml) delegates first to `slice-soft/ss-pipeline/.github/workflows/create-release.yml@v0`.

That reusable workflow does two things:

- runs `release-please`
- updates the major tag such as `v0` or `v1` after a release is created

When `release-please` reports that a release was actually created, the same local workflow then delegates to `slice-soft/ss-pipeline/.github/workflows/tf-docs.yml@v0` to regenerate Terraform reference docs and open a single follow-up PR. This keeps the docs PR from running in parallel with the release PR.

For this repository, the initial manifest is set to `0.0.0` in [`.release-please-manifest.json`](../.release-please-manifest.json). That allows the first real `feat:` release to become `v0.1.0`.

## Terraform Docs Flow

Terraform docs are generated from the local [`.github/workflows/release.yml`](../.github/workflows/release.yml), which delegates to `slice-soft/ss-pipeline/.github/workflows/tf-docs.yml@v0` only after a release is created.

It currently targets:

- `modules/pages`

The reusable workflow expects each managed README to contain these markers:

```md
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

When Terraform inputs or outputs change and a release is published, the workflow regenerates the reference section and opens a PR instead of pushing directly to `main`.

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
