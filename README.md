# Reproducible E-Commerce Batch Data Pipeline with Looker & BigQuery

A concise, reproducible batch pipeline that ingests a static [e-commerce CSV dataset](https://www.kaggle.com/datasets/carrie1/ecommerce-data), applies repeatable transformations and tests with dbt, persists curated datasets in BigQuery, and surfaces governed analytics via Looker (static dashboard included).

This project uses the 2010–2011 transactions dataset to validate the pipeline by measuring transaction volume over time, surfacing seasonal patterns, and demonstrating end-to-end reproducibility and observability.

---

## 🧱 Architecture Overview

Raw CSV → Airflow (orchestration) → BigQuery (warehouse) → dbt (staging → marts) → Looker (semantic layer + dashboard)

- Airflow: schedules and orchestrates jobs (no transformation logic).
- dbt: cleans, models, and tests data (staging → marts).
- BigQuery: stores raw, staged, and mart tables (single source of truth).
- Looker: provides LookML semantic layer and hosts dashboards.
- Terraform: codifies cloud infrastructure.
- Docker: ensures reproducibility.

---

## 📁 Project Structure (high level)

data-pipeline-demo/
- docker/                  — Dockerfiles and docker-compose
- airflow/                 — DAGs and requirements
- dbt/                     — dbt project, profiles, models, tests
- looker/                  — LookML models, views, dashboards, screenshots
- terraform/               — minimal infra definitions
- data/raw/                — sample datasets (CSV)
- scripts/                 — helper scripts (run/build)
- .env.example, Makefile, README.md

See the repository for full file listing and details.

---

## 🔄 Pipeline Responsibilities

Airflow
- Orchestrates the batch workflow and manages dependencies.
- Does not contain business transformation logic.

dbt
- Implements all transformation logic and tests.
- Layers:
  - staging — light cleanup and renames
  - marts — analytics-ready fact and dimension tables

BigQuery
- Stores raw, staged, and mart tables and serves analytics queries.

Looker
- Connects to BigQuery, consumes dbt marts, and provides governed metrics and dashboards.
- LookML and dashboard exports are version-controlled here.

---

## 📊 Dashboard

- A static Looker dashboard and LookML models are included in the `looker/` directory.
- Dashboard definitions and screenshots provided for reproducibility and review.
- See `looker/README.md` for metric definitions and dashboard details.

---

## 🛠️ Setup & Reproducibility

This project targets reproducible local runs (Docker) and GitHub Codespaces.

### Prerequisites
- Docker & Docker Compose
- (Optional) GitHub Codespaces
- GCP project with BigQuery (for production runs)
- Looker instance connected to BigQuery (for dashboarding)

### Quick start (local / Codespaces)
1. Copy environment:  
   cp .env.example .env
2. Start services:  
   docker compose up

(Optional) Provision GCP resources:
```bash
cd terraform
terraform init
terraform apply
```

Notes:
- Secrets and credentials must be set via environment variables or secret manager prior to running dbt/Looker provisioning.
- Use the provided scripts in `scripts/` for common workflows.

---

## 🎯 Design Decisions

- Batch-first architecture; streaming is out of scope.
- All business logic lives in dbt (not Airflow or Looker).
- Looker is used as a semantic layer (not for transformations).
- Infrastructure is minimal and codified for reproducibility.

---

## 🚫 Out of Scope

- Real-time/streaming ingestion
- Monitoring/alerting
- CI/CD pipelines (not included)
- Autoscaling / high-availability configurations

These omissions are intentional to keep the demo focused and easy to reproduce.

---

## Contributing

- Open an issue for design questions or bugs.
- Use branches named feature/<name> or fix/<name>.
- Keep changes small and document rationale in PR descriptions.

---

## License

Included source files are licensed as noted in the repository. Check the LICENSE file (if present) for terms.

---

For more details, walkthroughs, and LookML specifics, see the individual directories:
- looker/README.md
- dbt/
- airflow/
- terraform/
