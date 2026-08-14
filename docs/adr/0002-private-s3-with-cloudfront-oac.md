# ADR 0002: Private S3 bucket + CloudFront OAC (not S3 website hosting)

**Status:** Accepted · **Date:** 2026-08-14

## Context

S3 offers a public "static website hosting" mode that is simpler to set up. It serves HTTP only, exposes the bucket publicly, and is the most common S3 misconfiguration reported in breach postmortems.

## Decision

The bucket blocks all public access. CloudFront reads it through Origin Access Control (SigV4-signed origin requests), gated by a bucket policy conditioned on the distribution's ARN. Viewers get HTTPS, HTTP/2, and edge caching.

## Consequences

- The bucket is unreachable directly; the only path is the CDN.
- ACM certificate must live in us-east-1 (CloudFront requirement) — hence the aliased provider.
- Slightly more Terraform, but the pattern matches what production teams actually run.
