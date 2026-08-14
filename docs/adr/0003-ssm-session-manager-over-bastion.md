# ADR 0003: SSM Session Manager instead of a bastion host

**Status:** Accepted · **Date:** 2026-08-14

## Context

Private instances need operator access. The classic answer is a bastion (jump) host in a public subnet with port 22 open, SSH keys distributed to each operator.

## Decision

Instances run the SSM agent and an instance profile with `AmazonSSMManagedInstanceCore`. The agent opens an *outbound* HTTPS channel to Systems Manager; operators connect with `aws ssm start-session`. The instance security group has **zero ingress rules** and instances have no public IPs. IMDSv2 is enforced.

## Consequences

- No SSH keys to rotate or leak; no port 22 anywhere; no bastion to patch or pay for.
- Every session is IAM-authenticated and auditable in CloudTrail.
- Trade-off: requires internet egress (NAT) or SSM VPC endpoints; endpoints are the planned next step to remove even that.
