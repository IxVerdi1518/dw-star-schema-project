# Business Case

## Context
A financial analytics team needs to analyze historical cryptocurrency market snapshots to support BI dashboards, market trend analysis, and ranking reports.

## Objective
Build a dimensional Data Warehouse using a star schema to support analytical queries on cryptocurrency prices, market capitalization, trading volume, and percentage changes over time.

## Main KPIs
- Average cryptocurrency price
- Total market capitalization
- Total traded volume
- Top 10 cryptocurrencies by market cap
- Top 10 cryptocurrencies by volume
- Highest 24h gainers
- Highest 24h losers

## Analytical dimensions
- Date
- Cryptocurrency

## Fact grain
One row per cryptocurrency per snapshot date.