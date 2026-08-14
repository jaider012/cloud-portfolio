# 12-Week Roadmap

## Phase 1 — Foundations (Weeks 1–3)

- **Week 1 — Static site + first deployment.** Portfolio site on S3 + CloudFront + ACM (HTTPS). Done twice: console first, then Terraform. Touches DNS, CDN, TLS, object storage, IaC.
- **Week 2 — VPC from scratch.** 2 public + 2 private subnets across 2 AZs, IGW, NAT, route tables, security groups. Private EC2 reached via SSM Session Manager (no open SSH port).
- **Week 3 — Containers.** Small Node.js API (URL shortener), Dockerized, local `docker compose` with Postgres, then ECR + ECS Fargate behind an ALB inside the Week 2 VPC.

## Phase 2 — Integration (Weeks 4–8)

- **Weeks 4–5 — Serverless + CI/CD.** Uptime monitor: scheduled Lambda → DynamoDB → SNS alerts. Full GitHub Actions pipeline: push → test → deploy. Least-privilege IAM. CloudWatch alarms.
- **Weeks 6–7 — Azure counterpart.** Deploy the Week 3 API to Azure Container Apps with VNet + NSGs + private endpoint to Azure Postgres. Write "AWS vs Azure" comparison doc.
- **Week 8 — Buffer + observability.** Catch-up, structured logging, dashboards, one real alert. Record 2–3 min demo videos.

## Phase 3 — Capstone + job prep (Weeks 9–12)

- **Weeks 9–10 — Capstone.** Three-tier app: CloudFront → ECS Fargate (multi-AZ, autoscaling) → RDS Postgres (private). Staging + prod environments, zero-downtime deploys, Secrets Manager, ADR docs, cost estimate.
- **Week 11 — Portfolio polish.** Update portfolio site with all projects. README template: What → Diagram → Key decisions → How to run → What I'd improve. LinkedIn posts. Pin best 4 repos.
- **Week 12 — Interview prep.** 2-minute spoken walkthrough per project, drill VPC/pipeline/secrets questions, mock interviews. **Start applying in Week 10.**

## Weekly rules

1. Ship every Friday — commit + README update.
2. `terraform destroy` after demos; keep screenshots as proof.
3. Stuck > 2h → write it down, move on, document the fix later.
4. After each build, write 3 sentences on *why* the architecture is shaped that way.
5. Extra time goes to depth (tests, K8s), not new projects.
