# Azure MLOps Framework

A production-ready MLOps framework built on Azure Machine Learning, using CLI v2 (YAML-first), Terraform for infrastructure, and GitHub Actions for CI/CD.

## Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    GitHub Actions CI/CD                   │
├──────────┬──────────┬──────────┬─────────────────────────┤
│  Dev WS  │  QA WS   │  Prd WS  │  Shared ML Registry    │
│  (train) │ (validate)│ (serve)  │  (models, components,  │
│          │          │          │   environments)         │
├──────────┴──────────┴──────────┴─────────────────────────┤
│              ADLS Gen2 (Data Layer)                       │
└──────────────────────────────────────────────────────────┘
```

## Repository Structure

- `terraform/` — Infrastructure as Code (modules, templates, per-environment projects)
- `azure-ml/projects/` — Project-segregated Azure ML assets
- `shared/` — Shared Python utilities
- `.github/workflows/` — CI/CD pipelines

### Multi-Project ML Layout

Each ML project is self-contained under:

- `azure-ml/projects/<project_name>/config`
- `azure-ml/projects/<project_name>/environments`
- `azure-ml/projects/<project_name>/components`
- `azure-ml/projects/<project_name>/pipelines`
- `azure-ml/projects/<project_name>/models`
- `azure-ml/projects/<project_name>/endpoints`

Current reference implementation:

- `azure-ml/projects/sample-project/`

## Getting Started

See the individual module and template READMEs under `terraform/` for details on infrastructure provisioning.

## Phase 2 Workflows (Environments and Components)

Phase 2 uses two ML-focused GitHub workflows:

- `ml-environment-build.yml` validates and registers project environments.
- `ml-components-register.yml` validates and registers project components.

### Trigger Behavior

- Terraform workflows (`terraform-plan.yml`, `terraform-apply.yml`) only run for `terraform/**` changes.
- ML workflows only run for `azure-ml/projects/**` and their own workflow file changes.
- This keeps infrastructure and ML asset pipelines decoupled.

### Manual Invocation

From the GitHub Actions UI, run either ML workflow with:

- `project_name`: folder name under `azure-ml/projects` (default: `sample-project`)
- `target_environment`: `dev`, `qa`, or `prd`
- `register_assets`: `true` to register in the shared registry, `false` for validation-only execution

### Version Outputs

Each successful registration publishes a project-scoped artifact manifest:

- `<project_name>-environment-versions` containing `<project_name>-environment-versions.json`
- `<project_name>-component-versions` containing `<project_name>-component-versions.json`

These manifests are the handoff for downstream phases (pipeline execution, model registration, endpoint deployment).

### Adding a New ML Project

1. Create `azure-ml/projects/<new_project_name>/` with the same folder layout as `sample-project`.
2. Prefix environment names with `<new_project_name>-` and component names with `<new_project_name>_` (AML component names only allow lowercase letters, numbers, and underscores).
3. Run ML workflows with `project_name=<new_project_name>`.
