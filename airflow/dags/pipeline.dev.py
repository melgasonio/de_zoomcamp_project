from datetime import datetime
import subprocess

from airflow import DAG
from airflow.operators.bash import BashOperator

with DAG(
    dag_id="ecommerce_pipeline_postgres",
    start_date=datetime(2026, 3, 4),
    schedule=None,  
    catchup=False,
    tags=["dbt", "postgres", "ecommerce"], 
) as dag:

    ingest_to_postgres = BashOperator(
        task_id = "ingest_to_postgres",
        bash_command = "python /usr/app/dbt/ingest.py",
    )

    run_dbt_models = BashOperator(
        task_id = "run_dbt_models",
        bash_command = "dbt run --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt --target dev",
    )
    
    run_dbt_tests = BashOperator(
        task_id = "run_dbt_tests",
        bash_command = "dbt test --project-dir /usr/app/dbt --profiles-dir /usr/app/dbt --target dev",
    )

    ingest_to_postgres >> run_dbt_models >> run_dbt_tests