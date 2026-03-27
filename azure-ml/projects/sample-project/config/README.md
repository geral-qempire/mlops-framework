# Sample Project Config Contract

This directory stores non-secret, environment-specific targeting values for `sample-project`.

## Contract Keys

- `subscription_id`: Azure subscription identifier, sourced from `${AZURE_SUBSCRIPTION_ID}` in CI.
- `location`: Azure region for workspace and registry actions.
- `resource_group`: Resource group for environment-scoped workspace operations.
- `workspace_name`: Azure ML workspace name per environment.
- `registry_name`: Shared Azure ML registry used for immutable asset registration.

## Files

- `dev.yml`
- `qa.yml`
- `prd.yml`

## Workflow Usage

ML workflows resolve config from `azure-ml/projects/<project_name>/config/<target_environment>.yml`.
