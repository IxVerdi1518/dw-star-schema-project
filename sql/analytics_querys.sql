-- =========================================================
-- 1. TOP 10 criptomonedas por market cap
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.current_price,
    f.market_cap,
    f.total_volume
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY f.market_cap DESC
LIMIT 10;


-- =========================================================
-- 2. TOP 10 criptomonedas por volumen
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.total_volume,
    f.market_cap,
    f.current_price
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY f.total_volume DESC
LIMIT 10;


-- =========================================================
-- 3. Precio promedio de las criptomonedas
-- =========================================================
SELECT
    d.full_date,
    ROUND(AVG(f.current_price), 2) AS avg_price
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;


-- =========================================================
-- 4. Market cap total del snapshot
-- =========================================================
SELECT
    d.full_date,
    ROUND(SUM(f.market_cap), 2) AS total_market_cap
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;


-- =========================================================
-- 5. Volumen total negociado
-- =========================================================
SELECT
    d.full_date,
    ROUND(SUM(f.total_volume), 2) AS total_volume
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.full_date
ORDER BY d.full_date;


-- =========================================================
-- 6. Monedas con mayor variación porcentual en 24h
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.price_change_24h,
    f.current_price
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY f.price_change_24h DESC NULLS LAST
LIMIT 10;


-- =========================================================
-- 7. Monedas con peor variación porcentual en 24h
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.price_change_24h,
    f.current_price
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY f.price_change_24h ASC NULLS LAST
LIMIT 10;


-- =========================================================
-- 8. Ranking por market cap
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.market_cap,
    RANK() OVER (ORDER BY f.market_cap DESC) AS market_cap_rank
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY market_cap_rank
LIMIT 20;


-- =========================================================
-- 9. Ranking por volumen
-- =========================================================
SELECT
    d.full_date,
    c.name,
    c.symbol,
    f.total_volume,
    RANK() OVER (ORDER BY f.total_volume DESC) AS volume_rank
FROM dw_star.fact_crypto_market f
JOIN dw_star.dim_coin c
    ON f.coin_key = c.coin_key
JOIN dw_star.dim_date d
    ON f.date_key = d.date_key
ORDER BY volume_rank
LIMIT 20;


-- =========================================================
-- 10. Resumen general del snapshot
-- =========================================================
SELECT
    COUNT(*) AS total_cryptos,
    ROUND(AVG(current_price), 2) AS avg_price,
    ROUND(SUM(market_cap), 2) AS total_market_cap,
    ROUND(SUM(total_volume), 2) AS total_volume
FROM dw_star.fact_crypto_market;