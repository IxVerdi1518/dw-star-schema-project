CREATE OR REPLACE VIEW dw_star.vw_crypto_market_enriched AS
SELECT
    f.market_fact_key,
    d.full_date,
    d.year,
    d.month,
    d.month_name,
    d.quarter,
    d.week_of_year,
    c.coin_key,
    c.coin_id,
    c.name,
    c.symbol,
    f.current_price,
    f.market_cap,
    f.total_volume,
    f.high_24h,
    f.low_24h,
    f.price_change_1h,
    f.price_change_24h,
    f.price_change_7d,
    f.snapshot_utc
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key;