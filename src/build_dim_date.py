import pandas as pd
from sqlalchemy import text

from db_connection import get_engine
from logger import get_logger

logger = get_logger("build_dim_date")

def generate_dim_date(start_date: str, end_date: str) -> pd.DataFrame:
    dates = pd.date_range(start=start_date, end=end_date, freq="D")

    df = pd.DataFrame({
        "full_date": dates
    })

    df["date_key"] = df["full_date"].dt.strftime("%Y%m%d").astype(int)
    df["day"] = df["full_date"].dt.day
    df["month"] = df["full_date"].dt.month
    df["year"] = df["full_date"].dt.year
    df["quarter"] = df["full_date"].dt.quarter
    df["week_of_year"] = df["full_date"].dt.isocalendar().week.astype(int)
    df["day_name"] = df["full_date"].dt.day_name()
    df["month_name"] = df["full_date"].dt.month_name()

    return df[
        [
            "date_key",
            "full_date",
            "day",
            "month",
            "year",
            "quarter",
            "week_of_year",
            "day_name",
            "month_name",
        ]
    ]

def load_dim_date(df: pd.DataFrame):
    engine = get_engine()

    with engine.begin() as conn:
        for _, row in df.iterrows():
            stmt = text("""
                INSERT INTO dw_star.dim_date (
                    date_key, full_date, day, month, year,
                    quarter, week_of_year, day_name, month_name
                )
                VALUES (
                    :date_key, :full_date, :day, :month, :year,
                    :quarter, :week_of_year, :day_name, :month_name
                )
                ON CONFLICT (date_key) DO NOTHING;
            """)
            conn.execute(
                stmt,
                {
                    "date_key": int(row["date_key"]),
                    "full_date": row["full_date"].date(),
                    "day": int(row["day"]),
                    "month": int(row["month"]),
                    "year": int(row["year"]),
                    "quarter": int(row["quarter"]),
                    "week_of_year": int(row["week_of_year"]),
                    "day_name": row["day_name"],
                    "month_name": row["month_name"],
                },
            )

def main():
    logger.info("Generando dim_date...")
    df = generate_dim_date("2020-01-01", "2030-12-31")
    logger.info(f"Filas generadas: {len(df)}")

    load_dim_date(df)
    logger.info("dim_date cargada correctamente.")

if __name__ == "__main__":
    main()