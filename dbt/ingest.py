import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()  # looks for .env in project root

# Get credentials
PG_USER = os.getenv("PG_USER")
PG_PASSWORD = os.getenv("PG_PASSWORD")
PG_DB = os.getenv("PG_DB")
PG_HOST = os.getenv("PG_HOST")
PG_PORT = os.getenv("PG_PORT")

# Connect to Postgres
engine = create_engine(f"postgresql+psycopg2://{PG_USER}:{PG_PASSWORD}@{PG_HOST}:{PG_PORT}/{PG_DB}")

# Load CSV
df = pd.read_csv("data/raw/trips.csv")

# Write to Postgres table
df.to_sql("raw_trips", engine, if_exists="replace", index=False)

print("CSV loaded into Postgres table: raw_trips")
