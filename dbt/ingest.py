import pandas as pd
from sqlalchemy import create_engine, text
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
csv_file = "/usr/app/data/raw/data.csv"
df = pd.read_csv(csv_file, encoding="ISO-8859-1")
df.columns = df.columns.str.lower()

# Execute the DROP CASCADE manually
with engine.begin() as conn:
    conn.execute(text("DROP TABLE IF EXISTS orders CASCADE;"))

# Write to Postgres table
df.to_sql("orders", engine, if_exists="replace", index=False)

print("CSV loaded into Postgres table: orders")
