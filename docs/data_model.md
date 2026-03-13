# Data Model

## Star Schema Overview

This project uses a dimensional model with one fact table and two dimensions.

### Fact Table: fact_crypto_market
Stores the measurable market metrics for each cryptocurrency on a given snapshot date.

**Measures**
- current_price
- market_cap
- total_volume
- high_24h
- low_24h
- price_change_1h
- price_change_24h
- price_change_7d

### Dimension: dim_coin
Stores descriptive attributes of each cryptocurrency.

**Attributes**
- coin_key
- coin_id
- symbol
- name

### Dimension: dim_date
Stores calendar attributes for analytical slicing.

**Attributes**
- date_key
- full_date
- day
- month
- year
- quarter
- week_of_year
- day_name
- month_name

## Grain
One row in the fact table represents one cryptocurrency at one snapshot date.

## Keys
- `coin_key` is a surrogate key from `dim_coin`
- `date_key` is an analytical key in YYYYMMDD format from `dim_date`