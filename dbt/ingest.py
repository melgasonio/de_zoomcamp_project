import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()  # looks for .env in project root

# Get credentials
PG_USER = os.getenv("POSTGRES_USER")
PG_PASSWORD = os.getenv("POSTGRES_PASSWORD")
PG_DB = os.getenv("POSTGRES_DB")
PG_HOST = os.getenv("POSTGRES_HOST")
PG_PORT = os.getenv("POSTGRES_PORT")

# Connect to Postgres
engine = create_engine(f"postgresql+psycopg2://{PG_USER}:{PG_PASSWORD}@{PG_HOST}:{PG_PORT}/{PG_DB}")

# Load CSV
csv_file = "data/raw/data.csv"
df = pd.read_csv(csv_file, encoding="ISO-8859-1")

# Write to Postgres table
df.to_sql("raw_ecom", engine, if_exists="replace", index=False)

print("CSV loaded into Postgres table: raw_ecom")
