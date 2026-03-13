import json
from pathlib import Path
from sqlalchemy import text
import pandas as pd

from db_connection import get_engine
from logger import get_logger

logger = get_logger("load_fact")

DATA_PATH = Path("/Users/edflorese/Documents/cripto-data-pipeline/data/bronze/coins_markets/coins_markets_2026-03-02T16:02:10Z.json")

def load_json():
    with open(DATA_PATH, "r", encoding="utf-8") as f:
        payload = json.load(f)
    return payload

def main():
    logger.info("Cargando fact_crypto_market...")

    payload = load_json()
    snapshot = payload["meta"]["fetched_at_utc"]

    df = pd.json_normalize(payload["data"])

    # Convertir snapshot ISO8601 a datetime real
    snapshot_dt = pd.to_datetime(snapshot, format="ISO8601")
    date_key = int(snapshot_dt.strftime("%Y%m%d"))

    df["snapshot_utc"] = snapshot_dt
    df["date_key"] = date_key

    engine = get_engine()

    inserted_rows = 0

    with engine.begin() as conn:
        for _, row in df.iterrows():
            coin_key = conn.execute(
                text("""
                    SELECT coin_key
                    FROM dw_star.dim_coin
                    WHERE coin_id = :coin_id
                """),
                {"coin_id": row["id"]}
            ).scalar()

            if coin_key is None:
                logger.warning(f"No existe coin_key para coin_id={row['id']}, se omite registro.")
                continue

            stmt = text("""
                INSERT INTO dw_star.fact_crypto_market (
                    date_key,
                    coin_key,
                    current_price,
                    market_cap,
                    total_volume,
                    high_24h,
                    low_24h,
                    price_change_1h,
                    price_change_24h,
                    price_change_7d,
                    snapshot_utc
                )
                VALUES (
                    :date_key,
                    :coin_key,
                    :current_price,
                    :market_cap,
                    :total_volume,
                    :high_24h,
                    :low_24h,
                    :price_change_1h,
                    :price_change_24h,
                    :price_change_7d,
                    :snapshot_utc
                )
            """)

            conn.execute(stmt, {
                "date_key": date_key,
                "coin_key": coin_key,
                "current_price": row.get("current_price"),
                "market_cap": row.get("market_cap"),
                "total_volume": row.get("total_volume"),
                "high_24h": row.get("high_24h"),
                "low_24h": row.get("low_24h"),
                "price_change_1h": row.get("price_change_percentage_1h_in_currency"),
                "price_change_24h": row.get("price_change_percentage_24h_in_currency"),
                "price_change_7d": row.get("price_change_percentage_7d_in_currency"),
                "snapshot_utc": snapshot_dt.to_pydatetime()
            })

            inserted_rows += 1

    logger.info(f"Filas insertadas: {inserted_rows}")

if __name__ == "__main__":
    main()