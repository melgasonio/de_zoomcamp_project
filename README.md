# E-Commerce Revenue Data

![Google Cloud](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![Apache Airflow](https://img.shields.io/badge/Apache_Airflow-017CEE?style=for-the-badge&logo=apacheairflow&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Looker](https://img.shields.io/badge/Looker-4285F4?style=for-the-badge&logo=looker&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

> An automated ELT pipeline that extracts daily retail data, loads it into a data warehouse, and transforms it into analytics-ready models.

```mermaid
flowchart LR
    subgraph Orchestration & Infrastructure
        TF[Terraform] -. "Provisions" .-> GCP
        AF[Apache Airflow] -. "Orchestrates" .-> Python
        AF -. "Triggers" .-> dbt
    end

    subgraph Extraction & Load
        CSV[Raw CSV Files] --> Python(ingest_bq.py)
        Python --> BQ_Raw[(BigQuery: Raw Dataset)]
    end

    subgraph Transformation
        BQ_Raw --> dbt{dbt Models}
        dbt --> BQ_Prod[(BigQuery: Analytics Dataset)]
    end

    subgraph Presentation
        BQ_Prod --> Looker[Looker Dashboard]
    end

    style TF fill:#844FBA,stroke:#fff,color:#fff
    style AF fill:#017CEE,stroke:#fff,color:#fff
    style BQ_Raw fill:#669DF6,stroke:#fff,color:#fff
    style BQ_Prod fill:#669DF6,stroke:#fff,color:#fff
    style dbt fill:#FF694B,stroke:#fff,color:#fff
    style Python fill:#3776AB,stroke:#fff,color:#fff
    style Looker fill:#4285F4,stroke:#fff,color:#fff
```


## Final Dashboard
[![dashboard screenshot](looker/image.png)](https://lookerstudio.google.com/reporting/17ed0c92-35b6-4e93-8588-0c55e4780d37)

## Data Source
[E-Commerce Data from Kaggle](https://www.kaggle.com/datasets/carrie1/ecommerce-data)

## Problem Statement
**Objective**: The goal of this project is to provide a scalable, automated solution for analyzing global e-commerce performance. Currently, raw transaction data is stored in disconnected CSV files, making it difficult for stakeholders to identify revenue trends by geographic region and time.

**Key Business Questions**:
- Which countries are the top contributors to total revenue?
- How does monthly revenue trend throughout the year (identifying seasonality)?
- Can we automate the ingestion and cleaning process to ensure data consistency?

**Solution**:
A batch-processed data pipeline that automates the extraction of CSV data, transforms it within a BigQuery Data Warehouse using dbt, and visualizes the results in a Looker Studio dashboard.

## Project Structure
```text
.
├── Makefile                           # Command shortcuts (make local-up)
├── README.md                          # Main project documentation
├── airflow/                           # Airflow orchestration environment
│   ├── dags/                          # Pipeline definition files (DAGs)
│   ├── plugins/                       # Custom Airflow operators and hooks
│   ├── requirements.dev.txt           # Local Airflow dependencies
│   └── requirements.txt               # Production Airflow dependencies
├── data/                              # Local data storage
│   └── raw/                           # Raw CSV files (ignored in git)
├── dbt/                               # Data transformation layer
│   ├── dbt_project.yml                # Main dbt configuration file
│   ├── ingest.py                      # Python extraction script
│   ├── ingest_bq.py                   # Python BigQuery loading script
│   ├── models/                        # SQL transformation models
│   ├── profiles.yml                   # dbt connection profiles
│   ├── requirements.dev.txt           # Local dbt dependencies
│   ├── requirements.txt               # Production dbt dependencies
│   ├── target/                        # Compiled dbt output (ignored in git)
│   └── tests/                         # Custom data quality tests
├── docker/                            # Containerization setup
│   ├── airflow/                       # Custom Airflow Dockerfile
│   ├── dev/                           # Local docker-compose configuration
│   └── prod/                          # Prod docker-compose configuration
├── looker/                            # Business Intelligence (BI) layer
├── sa_terraform_admin.json            # GCP Credentials (ignored in git)
└── terraform/                         # Infrastructure as Code (IaC)
```

## Pipeline
1. `ingest_to_bq` for `prod` or `ingest_to_bq` for `dev`: ingests data to Postgres or BQ depending on the target
2. `run_dbt_models`: builds and materializes all dbt staging, intermediate, and marts models
3. `run_dbt_tests`: executes dbt tests to validate data integrity across the pipeline

## Data Layers
![medallion architecture](data_layers.png)
This project strictly follows the Medallion Architecture to guarantee data quality, enforce a clear separation of concerns, and optimize performance for downstream analytics.

- **Source**: The pipeline begins with the raw e-commerce extraction (`data.csv`).
- **Bronze Layer (Raw & Staging)**: The initial landing zone. The data is ingested into raw_orders and immediately standardized in the `stg_order`s` dbt model. This layer focuses on foundational data governance, such as correcting data types and standardizing column casing, without altering the grain of the source data.
- **Silver Layer (Intermediate)**: The enrichment zone. In the `int_orders_enriched` model, raw data is cleansed and core business rules are applied. This includes filtering invalid records and deriving key business metrics (like calculating the `total_price` from `quantity` and `unit_price`) to create a single source of truth for downstream models.
- **Gold Layer (Marts/Consumption)**: The business-ready zone. This layer is heavily modeled for analytical queries and BI dashboards, utilizing a Star Schema approach:
    - `dim_countries`: A dimension table extracting all unique countries for categorical slicing.
    - `fct_order_items`: A granular fact table joining the enriched orders with surrogate keys from the dimension tables.
    - `fct_revenue_country_month`: A highly aggregated reporting table. This model is partitioned by country and month, making queries filtering for specific regional and temporal revenue significantly faster and more cost-effective.

## Setup Instructions

**Prequisites**
1. Install Docker. See installation instruction [here](https://docs.docker.com/engine/install/).*
2. Clone the Repository. Run:
```
git clone https://github.com/melgasonio/de_zoomcamp_project.git
cd de_zoomcamp_project
```

**Local Setup**
1. Create a `.env.local` file in the root with the following keys
- `POSTGRES_USER`: your postgres service account username
- `POSTGRES_PASSWORD`: your postgres service account password
- `POSTGRES_DB`: name of database
- `POSTGRES_HOST`: value should be `postgres`
- `POSTGRES_PORT`: port to be forwarded, default is `5432`
- `PGADMIN_EMAIL`: your preferred pgAdmin UI username
- `PGADMIN_PASSWORD`: your preferred pgAdmin UI password
- `AIRFLOW_USER`: your preferred airflow username
- `AIRFLOW_PASS`: your preferred airflow password
2. Run `make local-up` to start the local containers.
3. Run a manual DAG trigger in Airflow UI or configure a schedule by setting the schedule arg of the DAG function to a CRON expression.
4. Optional cleanup: run `make local-down`.

**Cloud Setup**
1. Create a GCP project.
2. Under the project, create a Service Account. Grant it the **BigQuery Admin** role. 
3. Download the keyfile in JSON. Rename it to `sa_terraform_admin.json` and move it to the root.
4. Create a `.env` file in the root with the following keys:
- `GCP_KEYFILE`: the keyfile name including the file extension
- `GCP_PROJECT_ID`: your GCP project ID
- `GCP_REGION`: your GCP project's region
- `GCP_DATASET_ID`: your BigQuery dataset ID
- `AIRFLOW_USER`: your preferred airflow username
- `AIRFLOW_PASS`: your preferred airflow password
5. Run `make prod-up` to start the prod containers.
6. Run the following commands in order to create a BigQuery dataset resource:
- `make terraform-init`: initializes the Terraform working directory
- `make terraform-plan`: generates an execution plan
- `make terraform-apply`: executes the plan and provisions the infrastructure
- `make terraform-destroy` (*Optional*): safely removes the BigQuery dataset and any other resources managed by this configuration to prevent ongoing cloud costs
7. Run a manual DAG trigger in Airflow UI or configure a schedule by setting the schedule arg of the DAG function to a CRON expression.
8. Optional cleanup: run `make prod-down`.