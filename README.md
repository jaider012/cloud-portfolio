# Cloud Portfolio — 3-Month Build Log

**Started:** Aug 14, 2026 · **Author:** Jaider Panqueva ([@jaider012](https://github.com/jaider012))

Hands-on portfolio integrating **programming, cloud (AWS/Azure), and networking**. Every project includes working code, infrastructure-as-code, an architecture diagram, and the reasoning behind each decision.

## Projects

| # | Project | Stack | Status |
|---|---------|-------|--------|
| 1 | [Static site on S3 + CloudFront](./week1-static-site) | HTML/CSS, S3, CloudFront, ACM, Route 53, Terraform | 🚧 In progress |
| 2 | [VPC networking lab](./week2-vpc-lab) | VPC, subnets, NAT, SSM Session Manager, Terraform | 🚧 In progress |
| 3 | [Containerized API on ECS Fargate](./week3-containers-api) | Node.js, Docker, ECR, ECS Fargate, ALB, Terraform | 🚧 In progress |
| 4 | Serverless app + CI/CD (Weeks 4–5) | Lambda, DynamoDB, GitHub Actions | ⏳ Planned |
| 5 | Azure counterpart (Weeks 6–7) | Container Apps, VNet, Azure Pipelines | ⏳ Planned |
| 6 | Capstone: 3-tier production app (Weeks 9–10) | React, ECS, RDS, blue/green deploys | ⏳ Planned |

## Engineering practices

- **No AWS keys anywhere** — CI deploys via [GitHub OIDC federation](./docs/adr/0001-github-oidc-instead-of-aws-keys.md) ([`bootstrap/`](./bootstrap) creates the role, remote state bucket, and lock table).
- **Reusable modules** — networking lives in [`modules/network`](./modules/network) (multi-AZ, optional NAT-per-AZ, flow logs) and is consumed by the labs.
- **Security scanning in CI** — Trivy misconfiguration + secret scan blocks merges on HIGH/CRITICAL; Dependabot patches Actions, npm, Terraform, and Docker weekly.
- **Decisions are documented** — see [`docs/adr/`](./docs/adr) for why OIDC over keys, OAC over public buckets, SSM over bastions.
- **`make check`** runs everything CI runs, locally.

## Principles

- **Everything as code** — every resource is reproducible with `terraform apply`.
- **Least privilege** — no `*` IAM policies.
- **Tear down after demos** — screenshots/videos in `docs/`, infra destroyed to keep cost ≈ $0.
- **Explain the why** — each README has a "Key decisions" section.

See [ROADMAP.md](./ROADMAP.md) for the full 12-week plan.
