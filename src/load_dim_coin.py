import json
from pathlib import Path
from sqlalchemy import text

from db_connection import get_engine
from logger import get_logger

logger = get_logger("load_dim_coin")

DATA_PATH = Path("/Users/edflorese/Documents/cripto-data-pipeline/data/bronze/coins_markets/coins_markets_2026-03-02T16:02:10Z.json")

def load_json():
    with open(DATA_PATH, "r") as f:
        data = json.load(f)
    return data["data"]

def insert_dim_coin(coins):

    engine = get_engine()

    with engine.begin() as conn:

        for coin in coins:

            stmt = text("""
                INSERT INTO dw_star.dim_coin (
                    coin_id,
                    symbol,
                    name
                )
                VALUES (
                    :coin_id,
                    :symbol,
                    :name
                )
                ON CONFLICT (coin_id) DO NOTHING
            """)

            conn.execute(stmt, {
                "coin_id": coin["id"],
                "symbol": coin["symbol"],
                "name": coin["name"]
            })

def main():

    logger.info("Cargando dim_coin...")

    coins = load_json()

    insert_dim_coin(coins)

    logger.info(f"Monedas procesadas: {len(coins)}")

if __name__ == "__main__":
    main()