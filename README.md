# Sakila Sample Database Analysis

This repository contains a comprehensive collection of SQL queries for analyzing the Sakila Sample Database. These queries are designed to be efficient and optimized for execution time, resource utilization, query plan, index usage, join strategies, subquery and CTE usage, data retrieval, aggregation, and grouping.

## Table of Contents

- [Overview](#overview)
- [Setup and Installation](#setup-and-installation)
  - [Prerequisites](#prerequisites)
  - [Database Setup](#database-setup)
  - [Running Queries](#running-queries)
- [Query Collections](#query-collections)
  - [Top Rankings](#top-rankings)
  - [Revenue and Rentals](#revenue-and-rentals)
  - [Customer Analysis](#customer-analysis)
  - [Films and Actors](#films-and-actors)
  - [Time-Based Analysis](#time-based-analysis)
  - [Inventory Management](#inventory-management)
  - [Geographic Analysis](#geographic-analysis)
- [Query Optimization Techniques](#query-optimization-techniques)
- [Contributing](#contributing)
- [Change Log](#change-log)
- [License](#license)
- [References](#references)

## Overview

The Sakila Sample Database is a well-structured and comprehensive sample database provided by MySQL. It represents a fictional DVD rental store and includes tables for films, actors, customers, rentals, payments, and more. This repository provides a collection of SQL queries that analyze this database to extract meaningful business insights.

Key features of this analysis:
- Customer behavior and segmentation analysis
- Revenue and rental statistics
- Film popularity and inventory analysis
- Store performance comparison
- Actor filmography statistics
- Seasonal and daily rental patterns
- Geographic distribution of customers and revenue
- Inventory utilization and turnover metrics

> **Note on Sample Data:** The Sakila database is designed as a demonstration database and, as such, may have data that is not evenly distributed across all time periods. When interpreting results from time-based analyses, it's important to consider the specific data distribution in your instance of the database.

## Repository Structure

The repository is organized into a structured directory layout to make it easy to navigate and find specific queries:

```
sakila-analysis/
├── README.md
├── LICENSE
└── queries/
    ├── top-rankings/
    │   ├── top-10-most-rented-films.sql         		# Most popular films by rental count
    │   ├── top-5-popular-categories-per-store.sql 		# Top categories by store
    │   ├── top-10-overall-customers.sql         		# Customers with most rentals
    │   └── top-10-customers-per-store.sql       		# Top customers by store
    │
    ├── revenue/
    │   ├── total-revenue-per-store.sql          		# Revenue by store
    │   ├── store-revenue-and-avg-revenue.sql 		        # Revenue metrics
    │   └── store-total-rentals.sql                 		# Rental metrics
    │
    ├── customers/
    │   ├── customers-rented-from-both-stores.sql 		# Multi-store customers
    │   ├── top-10-customers-most-spent-per-store.sql 		# Top spenders by store
    │   ├── top-10-customers-who-spend-the-most-overall.sql 	# Overall top spenders
    │   ├── customer-lifetime-value.sql          		# Customer LTV analysis
    │   └── customer-rfm-analysis.sql            		# RFM segmentation
    │
    ├── films-actors/
    │   ├── total-and-avg-rental-duration-per-category.sql 	# Duration analysis
    │   ├── actors-in-more-than-10-films.sql     		# Prolific actors
    │   ├── film-profitability-analysis.sql      		# ROI analysis
    │   └── film-rating-vs-rental-performance.sql 		# Rating performance
    │
    ├── time-based/
    │   ├── seasonal-rental-patterns.sql         		# Monthly trends
    │   └── rentals-by-day-of-week.sql           		# Day of week analysis
    │
    ├── inventory/
    │   ├── inventory-turnover.sql               		# Inventory efficiency
    │   └── inventory-utilization.sql            		# Utilization percentage
    │
    └── geographic/
        ├── customer-distribution-by-geography.sql 		# Customer locations
        └── revenue-by-geography.sql             		# Revenue by location
```

This structure groups related queries together, making it easier to find specific analyses and understand the relationships between different query files.

## Setup and Installation

### Prerequisites

- MySQL Server 5.7+ or PostgreSQL 10+
- Basic knowledge of SQL
- The Sakila Sample Database

### Database Setup

1. Download the Sakila Sample Database from [MySQL's website](https://dev.mysql.com/doc/sakila/en/)
   - You'll need both the schema file (sakila-schema.sql) and the data file (sakila-data.sql)
2. Import the database into your MySQL server:
   ```bash
   mysql -u username -p < sakila-schema.sql
   mysql -u username -p < sakila-data.sql
   ```

> **Note**: The Sakila database files are not included in this repository and must be downloaded separately.

### Running Queries

1. Connect to your database:
   ```bash
   mysql -u username -p sakila
   ```
2. Execute a query:
   ```sql
   SOURCE queries/top_rankings/top-10-most-rented-films.sql
   ```

## Query Collections

### Top Rankings

#### Top 10 Most Rented Films
[View Query](queries/top-rankings/top-10-most-rented-films.sql)

**Technical explanation**: Calculates the top 10 most rented films by rental count. This improved query now includes additional film details like description, release year, rental rate, length, rating, and category. It also calculates the rentals per inventory item ratio.

**Why is this the best approach?**: The query directly calculates the rental count for each film using a simple join and aggregation strategy. The CTE approach improves readability, and the additional metrics provide more business context.

**Business case**: Identifying the top 10 most rented films can be used to understand customer preferences and trends, allowing for better inventory management and targeted marketing efforts.

#### Top 5 Popular Categories per Store
[View Query](queries/top-rankings/top-5-popular-categories-per-store.sql)

**Technical explanation**: Finds the top 5 most popular film categories for each store based on rental count. The improved query now includes store location details (address and city).

**Business case**: Understanding the top 5 popular categories per store can help management make informed decisions about inventory allocation and marketing efforts specific to each store location.

#### Top 10 Overall Customers
[View Query](queries/top-rankings/top-10-overall-customers.sql)

**Technical explanation**: Calculates the top 10 overall customers by rental count. The improved query now includes customer email, address, city, country, first/last rental dates, and customer rental period in days.

**Business case**: Identifying the top 10 overall customers can help the business understand and reward their most loyal customers, encouraging customer retention and fostering positive relationships.

#### Top 10 Customers per Store
[View Query](queries/top-rankings/top-10-customers-per-store.sql)

**Technical explanation**: Calculates the top 10 customers for each store by rental count. The improved query now includes customer email and store location details.

**Business case**: Identifying the top 10 customers per store can help store managers understand and reward their most loyal customers, encouraging customer retention and fostering positive relationships.

### Revenue and Rentals

#### Total Revenue per Store
[View Query](queries/revenue/total-revenue-per-store.sql)

**Technical explanation**: Calculates the total revenue per store. The improved query now traces revenue to the inventory's store rather than the staff's store, providing a more accurate view of which store's inventory is generating revenue. It also includes store location details, unique customers, average payment amount, and payment date range.

**Business case**: Understanding the total revenue per store can help management make informed decisions about store performance, budget allocation, and resource management.

#### Store Revenue and Average Revenue per Customer
[View Query](queries/revenue/store-revenue-and-avg-revenue.sql)

**Technical explanation**: Calculates the total revenue and average revenue per customer for each store. The improved query now includes store location details.

**Business case**: Understanding the total revenue and average revenue per customer for each store can help management assess the effectiveness of marketing strategies, customer retention efforts, and revenue generation tactics.

#### Store Total Rentals and Average Rentals per Customer
[View Query](queries/revenue/store-total-rentals.sql)

**Technical explanation**: Calculates the total rentals and average rentals per customer for each store. The improved query now includes store location details.

**Business case**: Understanding the total rentals and average rentals per customer for each store can help management evaluate customer engagement and rental trends, allowing for better inventory management and targeted marketing efforts.

### Customer Analysis

#### Customers Rented from Both Stores
[View Query](queries/customers/customers-rented-from-both-stores.sql)

**Technical explanation**: Identifies customers who have rented from both stores. The improved query now includes customer email, address, city, and country.

**Why is this the best approach?**: This approach using `EXISTS` is more efficient than using joins and `HAVING` clauses with `COUNT(DISTINCT)` for this specific use case.

**Business case**: Identifying customers who rented from both stores can help management understand customer behavior patterns, allowing for better customer segmentation and targeted marketing efforts.

#### Top 10 Customers Who Spend the Most per Store
[View Query](queries/customers/top-10-customers-most-spent-per-store.sql)

**Technical explanation**: Calculates the top 10 customers who spend the most in each store. The improved query now includes customer email, store location details, and rounds monetary values for better readability.

**Business case**: Identifying the top 10 customers who spend the most per store can help store managers understand and reward their high-value customers, encouraging customer retention and fostering positive relationships.

#### Top 10 Customers Who Spend the Most Overall
[View Query](queries/customers/top-10-customers-who-spend-the-most-overall.sql)

**Technical explanation**: Calculates the top 10 customers who spend the most overall across all stores. The improved query now includes customer email, address, city, country, payment count, payment date range, and average payment amount.

**Business case**: Identifying the top 10 customers who spend the most overall can help the business understand and reward their high-value customers, encouraging customer retention and fostering positive relationships.

#### Customer Lifetime Value
[View Query](queries/customers/customer-lifetime-value.sql)

**Technical explanation**: Calculates the lifetime value of customers based on their payment history. This query determines the monthly and annual value of each customer, as well as a projected three-year value.

**Business case**: Understanding customer lifetime value helps businesses prioritize customer relationships, allocate marketing resources efficiently, and develop retention strategies for high-value customers.

#### Customer RFM Analysis
[View Query](queries/customers/customer-rfm-analysis.sql)

**Technical explanation**: Segments customers based on Recency, Frequency, and Monetary value (RFM). This query assigns scores for each dimension and categorizes customers into segments like Champions, Loyal Customers, At Risk, etc.

**Business case**: RFM analysis is a powerful customer segmentation technique that helps businesses tailor marketing strategies to different customer groups based on their behavior patterns.

### Films and Actors

#### Total and Average Rental Duration per Category
[View Query](queries/films-actors/total-and-avg-rental-duration-per-category.sql)

**Technical explanation**: Calculates the total and average rental duration for each film category. The improved query now includes additional metrics like film count, minimum/maximum rental duration, standard deviation, average rental rate, and average film length.

**Business case**: Understanding the total and average rental duration per category can help management assess customer preferences and rental trends, allowing for better inventory management and targeted marketing efforts.

#### Actors in More Than 10 Films
[View Query](queries/films-actors/actors-in-more-than-10-films.sql)

**Technical explanation**: Identifies actors who have appeared in more than 10 films. The improved query uses more consistent formatting and uses the column alias in the ORDER BY clause for better readability.

**Business case**: Identifying actors who have appeared in more than 10 films can help the business understand which actors are popular among customers, allowing for better film selection and marketing efforts.

#### Film Profitability Analysis
[View Query](queries/films-actors/film-profitability-analysis.sql)

**Technical explanation**: Analyzes the profitability of films based on rental revenue vs. replacement cost. This query calculates metrics like total revenue, inventory cost, profit, ROI percentage, and rentals needed to break even.

**Business case**: Understanding film profitability helps optimize inventory decisions, pricing strategies, and identifies which film categories and ratings provide the best return on investment.

#### Film Rating vs. Rental Performance
[View Query](queries/films-actors/film-rating-vs-rental-performance.sql)

**Technical explanation**: Analyzes the relationship between film ratings (G, PG, PG-13, R, NC-17) and rental performance. This query compares metrics like average rentals per film, revenue per film, and percentage of total rentals/revenue across different ratings.

**Business case**: This analysis helps determine if certain film ratings are more popular or profitable, guiding acquisition decisions and store inventory composition.

### Time-Based Analysis

#### Seasonal Rental Patterns
[View Query](queries/time-based/seasonal-rental-patterns.sql)

**Technical explanation**: Analyzes rental patterns by month and year to identify seasonal trends. This query calculates rental count, revenue, and percentage change from the previous month for each month in the dataset.

**Business case**: Understanding seasonal rental patterns helps with inventory planning, staffing decisions, and marketing campaign timing to maximize revenue during peak periods and stimulate demand during slower periods.

#### Rentals by Day of Week
[View Query](queries/time-based/rentals-by-day-of-week.sql)

**Technical explanation**: Analyzes rental patterns by day of week to identify busy days. This query calculates metrics like rental count, revenue, and percentage of total rentals/revenue for each day of the week.

**Business case**: Understanding daily rental patterns helps optimize staffing schedules, plan promotions for slower days, and ensure adequate inventory is available during peak days.

### Inventory Management

#### Inventory Turnover
[View Query](queries/inventory/inventory-turnover.sql)

**Technical explanation**: Analyzes how frequently each film's inventory is rented. This query calculates metrics like monthly turnover rate, rentals per inventory item, and ROI ratio.

**Business case**: Inventory turnover analysis helps identify which films have high demand relative to their inventory levels, guiding decisions about adding more copies of popular films or reducing inventory of slow-moving titles.

#### Inventory Utilization
[View Query](queries/inventory/inventory-utilization.sql)

**Technical explanation**: Analyzes what percentage of time each film's inventory is rented out. This query calculates the total days rented vs. available for each film, providing a utilization percentage.

**Business case**: Understanding inventory utilization helps optimize inventory levels to maximize return on investment while maintaining sufficient availability for customer demand.

### Geographic Analysis

#### Customer Distribution by Geography
[View Query](queries/geographic/customer-distribution-by-geography.sql)

**Technical explanation**: Analyzes the geographical distribution of customers across countries and cities. This query calculates the number of customers in each location, percentage of country/total customers, and ranks cities within countries and overall.

**Business case**: Understanding the geographic distribution of customers helps with expansion planning, marketing targeting, and identifying underserved areas with growth potential.

#### Revenue by Geography
[View Query](queries/geographic/revenue-by-geography.sql)

**Technical explanation**: Analyzes the geographical distribution of revenue. This query calculates metrics like total revenue, revenue per customer, payments per customer, and percentage of country/total revenue for each city.

**Business case**: Geographic revenue analysis helps identify high-value markets, target marketing efforts to high-potential areas, and optimize revenue generation strategies based on regional performance.

## Query Optimization Techniques

All queries in this repository have been optimized using the following techniques:

- **Well-Structured Joins**: Using the most appropriate join types and ensuring logical join order to minimize unnecessary data processing.
- **Appropriate Use of CTEs**: Using Common Table Expressions (CTEs) to improve query readability and maintainability while breaking down complex logic into manageable components.
- **Efficient Aggregation**: Performing aggregations at the appropriate level to get accurate results with minimal data processing.
- **Strategic Window Functions**: Using window functions instead of self-joins where appropriate for cleaner and more efficient code.
- **Precise Column Selection**: Only selecting the columns needed for analysis rather than using SELECT *.
- **Effective Filtering**: Applying WHERE and HAVING clauses appropriately to filter data at the correct point in query execution.
- **Consistent Formatting**: Following SQL best practices for formatting to improve readability and maintainability.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Run the queries to ensure they work
5. Commit your changes: `git commit -m 'Add some feature'`
6. Push to the branch: `git push origin feature/your-feature-name`
7. Submit a pull request

### Coding Standards

To maintain consistency across all SQL queries:

- Use 2-space indentation
- Place clauses like SELECT, FROM, WHERE on their own lines
- Always qualify column names with table aliases
- Use CTE (WITH clause) for complex queries
- Use meaningful table aliases (e.g., `c` for customer, not random letters)
- Capitalize SQL keywords (e.g., SELECT, FROM, WHERE)
- Use consistent case for database objects (lowercase recommended)
- Use ROUND() for monetary values to improve readability

## Change Log

### v2.0.0 (2023-06-XX)
- Improved all existing queries with better formatting and additional metrics
- Added 10 new analysis queries: seasonal patterns, inventory turnover, geographic analysis, etc.
- Restructured repository organization
- Enhanced documentation with query optimization techniques
- Added detailed business cases for each analysis

### v1.0.0 (2023-01-XX)
- Initial release with 13 SQL queries
- Comprehensive README documentation

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## References

- MySQL Documentation Team. (2023). MySQL Reference Manual. Oracle Corporation.
- Oracle Corporation. (2019). Sakila sample database. Oracle Corporation.