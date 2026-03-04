import pandas as pd
from google.cloud import bigquery
import os

# Config
PROJECT_ID = os.getenv("GCP_PROJECT_ID", "de-zoomcamp-488912")
DATASET_ID = "de_zoomcamp"
TABLE_ID = "raw_orders"
KEYFILE = os.getenv("GCP_KEYFILE")

# Initialize client
client = bigquery.Client.from_service_account_json(KEYFILE)

# Load CSV
df = pd.read_csv("/usr/app/data/raw/data.csv", encoding="ISO-8859-1")

# Upload to BigQuery
table_ref = f"{PROJECT_ID}.{DATASET_ID}.{TABLE_ID}"
job = client.load_table_from_dataframe(df, table_ref)
job.result()  # Wait for completion

print(f"Loaded {len(df)} rows to {table_ref}")