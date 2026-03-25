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
- `azure-ml/` — Azure ML assets (environments, data, components, pipelines, endpoints)
- `shared/` — Shared Python utilities
- `.github/workflows/` — CI/CD pipelines

## Getting Started

See the individual module and template READMEs under `terraform/` for details on infrastructure provisioning.
