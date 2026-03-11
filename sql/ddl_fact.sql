CREATE TABLE dw_star.fact_crypto_market (
    market_fact_key SERIAL PRIMARY KEY,
    date_key INTEGER NOT NULL REFERENCES dw_star.dim_date(date_key),
    coin_key INTEGER NOT NULL REFERENCES dw_star.dim_coin(coin_key),
    current_price NUMERIC,
    market_cap NUMERIC,
    total_volume NUMERIC,
    high_24h NUMERIC,
    low_24h NUMERIC,
    price_change_1h NUMERIC,
    price_change_24h NUMERIC,
    price_change_7d NUMERIC,
    snapshot_utc TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_fact_crypto_market_date_key
ON dw_star.fact_crypto_market(date_key);

CREATE INDEX idx_fact_crypto_market_coin_key
ON dw_star.fact_crypto_market(coin_key);

CREATE INDEX idx_fact_crypto_market_snapshot_utc
ON dw_star.fact_crypto_market(snapshot_utc);