from datetime import datetime
import subprocess

from airflow import DAG
from airflow.operators.bash import BashOperator

with DAG(
    dag_id="ecommerce_pipeline",
    start_date=datetime(2026, 3, 4),
    schedule=None,  
    catchup=False,
    tags=["dbt", "bigquery", "ecommerce"], 
) as dag:

    ingest_to_bq = BashOperator(
        task_id = "ingest_to_bq",
        bash_command = "python /usr/app/dbt/ingest_bq.py",
    )

    run_dbt_models = BashOperator(
        task_id = "run_dbt_models",
        bash_command = "dbt run --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt --target prod",
    )
    
    run_dbt_tests = BashOperator(
        task_id = "run_dbt_tests",
        bash_command = "dbt test --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt --target prod",
    )

    ingest_to_bq >> run_dbt_models >> run_dbt_tests