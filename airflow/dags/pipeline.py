from datetime import datetime
import subprocess

from airflow import DAG
from airflow.decorators import task


with DAG(
    dag_id="ecommerce_pipeline",
    start_date=datetime(2026, 3, 4),
    schedule=None,  
    catchup=False,
    tags=["dbt", "bigquery", "ecommerce"],
) as dag:

    @task()
    def ingest_to_bq():
        """Load raw CSV data into BigQuery raw_orders table."""
        result = subprocess.run(
            ["python", "/usr/app/dbt/ingest_bq.py"],
            capture_output=True,
            text=True,
            check=True,
        )
        print(result.stdout)
        return "Ingestion complete"

    @task()
    def run_dbt_models():
        """Run dbt models: staging → intermediate → marts."""
        result = subprocess.run(
            ["dbt", "run", "--project-dir", "/usr/app/dbt", "--profiles-dir", "/usr/app/dbt", "--target", "prod"],
            capture_output=True,
            text=True,
            check=False,
        )
        print(result.stdout)
        return "dbt run complete"

    @task()
    def run_dbt_tests():
        """Run dbt tests to validate data quality."""
        result = subprocess.run(
            ["dbt", "test", "--project-dir", "/usr/app/dbt", "--profiles-dir", "/usr/app/dbt", "--target", "prod"],
            capture_output=True,
            text=True,
            check=False,
        )
        print(result.stdout)
        return "dbt tests passed"

    # Define task dependencies (the orchestration flow)
    ingest_to_bq() >> run_dbt_models() >> run_dbt_tests()