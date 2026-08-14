# ADR 0001: GitHub OIDC federation instead of stored AWS keys

**Status:** Accepted · **Date:** 2026-08-14

## Context

CI needs AWS permissions to deploy. The common shortcut is creating an IAM user and pasting its access keys into GitHub secrets. Those keys are long-lived, invisible when leaked, and routinely the root cause of cloud breaches.

## Decision

GitHub Actions assumes an IAM role through OIDC federation (`token.actions.githubusercontent.com`). The trust policy pins the `sub` claim to `repo:jaider012/cloud-portfolio:ref:refs/heads/main` — only workflows on this repo's main branch can obtain credentials, which are temporary (1 hour) and scoped to exactly the S3 sync + CloudFront invalidation the deploy performs.

## Consequences

- Zero long-lived credentials in GitHub or in the repo.
- A fork or feature branch cannot deploy even if a workflow file is tampered with.
- Cost: one-time bootstrap stack (`bootstrap/`) must run before the first CI deploy.
