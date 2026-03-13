# Crypto Data Warehouse - Star Schema Project

## Overview
This project implements a dimensional Data Warehouse for cryptocurrency market analytics using a star schema in PostgreSQL.

The solution is designed to support analytical queries, BI dashboards, and historical trend analysis.

## Architecture
- PostgreSQL as analytical database
- Star schema model
- Fact table for market metrics
- Dimensions for date and cryptocurrency
- Python scripts for loading dimensions and facts
- SQL queries for business analysis

## Star Schema
- `dw_star.dim_coin`
- `dw_star.dim_date`
- `dw_star.fact_crypto_market`

## Fact Grain
One row per cryptocurrency per snapshot date.

## Main KPIs
- Average price
- Total market capitalization
- Total trading volume
- Top cryptocurrencies by market cap
- Top cryptocurrencies by volume
- Highest gainers and losers by 24h change

## Project Structure
- `sql/` → DDL, load scripts, analytics queries
- `src/` → Python loading scripts
- `docs/` → Business case and data model
- `data/` → Raw and processed data

## Technologies
- Python
- Pandas
- SQLAlchemy
- PostgreSQL
- SQL

## Learning Outcomes
This project demonstrates:
- Dimensional modeling
- Star schema design
- Fact and dimension loading
- Surrogate key usage
- Analytical SQL
- BI-oriented data architecture