DROP TABLE IF EXISTS dw_star.fact_crypto_market;
DROP TABLE IF EXISTS dw_star.dim_coin;
DROP TABLE IF EXISTS dw_star.dim_date;

CREATE TABLE dw_star.dim_coin (
    coin_key SERIAL PRIMARY KEY,
    coin_id VARCHAR(100) UNIQUE NOT NULL,
    symbol VARCHAR(50),
    name VARCHAR(100)
);

CREATE TABLE dw_star.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE UNIQUE NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    week_of_year INTEGER NOT NULL,
    day_name VARCHAR(20) NOT NULL,
    month_name VARCHAR(20) NOT NULL
);