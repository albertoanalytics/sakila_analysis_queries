# Sakila Sample Database Analysis

This repository contains a collection of SQL queries used to analyze the Sakila Sample Database. The queries are designed to be efficient and optimized for execution time, resource utilization, query plan, index usage, join strategies, subquery and CTE usage, data retrieval, aggregation, and grouping.

## Table of Contents

1. [Queries](#queries)
   1. [Top 10 Most Rented Films](#top-10-most-rented-films)
   2. [Total Revenue per Store](#total-revenue-per-store)
   3. [Customers Rented from Both Stores](#customers-rented-from-both-stores)
   4. [Total and Average Rental Duration per Category](#total-and-average-rental-duration-per-category)
   5. [Actors in More Than 10 Films](#actors-in-more-than-10-films)
   6. [Store Revenue and Average Revenue per Customer](#store-revenue-and-average-revenue-per-customer)
   7. [Store Total Rentals and Average Rentals per Customer](#store-total-rentals-and-average-rentals-per-customer)
   8. [Top 5 Popular Categories per Store](#top-5-popular-categories-per-store)
   9. [Top 10 Customers per Store](#top-10-customers-per-store)
   10. [Top 10 Overall Customers](#top-10-overall-customers)
   11. [Top 10 customers who spend the most per store](#top-10-customers-who-spend-the-most-per-store)
   12. [Top 10 customers who spend the most overall](#top-10-customers-who-spend-the most-overall)
2. [Usage](#usage)
3. [License](#license)

## Queries

### 1. Top 10 Most Rented Films(#top-10-most-rented-films)

- [Query file](./top_10_most_rented_films.sql)
- **Technical explanation**: Calculates the top 10 most rented films by rental count. This query joins the `rental`, `inventory`, and `film` tables, groups the results by film ID, title, and description, and uses the `COUNT` function to aggregate the rental count.
- **Why is this the best approach?**: The query is efficient because it directly calculates the rental count for each film using a simple join and aggregation strategy. This results in optimized execution time and resource utilization.
- **Business case**: Identifying the top 10 most rented films can be used to understand customer preferences and trends, allowing for better inventory management and targeted marketing efforts.

- [Home](#sakila-sample-database-analysis)

### 2. Total Revenue per Store(#total-revenue-per-store)

- [Query file](./total_revenue_per_store.sql)
- **Technical explanation**: Calculates the total revenue for each store by joining the `payment`, `rental`, and `inventory` tables, and groups the results by `store_id`. The `SUM` function is used to aggregate the total revenue for each store.
- **Why is this the best approach?**: The query directly calculates the total revenue for each store using a simple join and aggregation strategy. This results in optimized execution time and efficient resource utilization.
- **Business case**: Comparing the total revenue of each store provides insights into store performance, allowing for data-driven decision making in areas such as store operation and management.

- [Home](#sakila-sample-database-analysis)

### 3. Customers Rented from Both Stores

- [Query file](./customers_rented_from_both_stores.sql)
- **Technical explanation**: Finds customers who have rented films from both stores by joining the `customer`, `rental`, and `inventory` tables. This query uses a CTE to count rentals per customer per store and then selects customers with rentals from both stores using the `HAVING` clause.
- **Why is this the best approach?**: The use of a CTE allows for cleaner and more efficient code. By counting rentals per customer per store and filtering with the `HAVING` clause, the query efficiently identifies customers who have rented from both stores.
- **Business case**: Identifying customers who have rented from both stores may indicate high engagement and can be used to develop targeted marketing campaigns or special offers for loyal customers.

- [Home](#sakila-sample-database-analysis)

### 4. Total and Average Rental Duration per Category

- [Query file](./total_and_avg_rental_duration_per_category.sql)
- **Technical explanation**: Calculates the total and average rental duration for each film category by joining the `rental`, `inventory`, `film`, and `film_category` tables. This query groups the results by `category_id` and uses the `SUM` and `AVG` functions to aggregate the total and average rental duration, respectively.
- **Why is this the best approach?**: The query efficiently calculates the total and average rental duration for each film category using a simple join and aggregation strategy. This results in optimized execution time and resource utilization.
- **Business case**: The total and average rental duration per category can help identify popular film categories, allowing for better inventory management and targeted marketing efforts.

- [Home](#sakila-sample-database-analysis)

### 5. Actors in More Than 10 Films

- [Query file](./actors_in_more_than_10_films.sql)
- **Technical explanation**: Lists actors who have appeared in more than 10 films by joining the `actor`, `film_actor`, and `film` tables. This query groups the results by actor ID, first name, and last name and uses the `HAVING` clause to filter actors with more than 10 films.
- **Why is this the best approach?**: The query efficiently identifies actors with more than 10 film appearances using a simple join and aggregation strategy along with the `HAVING` clause for filtering. This results in optimized execution time and resource utilization.
- **Business case**: Identifying actors with a high number of film appearances can help assess the popularity of actors, which can be used for targeted marketing campaigns or acquisition of films featuring popular actors.

- [Home](#sakila-sample-database-analysis)

### 6. Store Revenue and Average Revenue per Customer

- [Query file](./store_revenue_and_avg_revenue_per_customer.sql)
- **Technical explanation**: Calculates the total revenue and average revenue per customer for each store by joining the `payment`, `rental`, and `inventory` tables. This query groups the results by `store_id` and uses the `SUM` and `AVG` functions to aggregate the total revenue and average revenue per customer, respectively.
- **Why is this the best approach?**: The query directly calculates the total revenue and average revenue per customer for each store using a simple join and aggregation strategy. This results in optimized execution time and efficient resource utilization.
- **Business case**: Comparing the total revenue and average revenue per customer of each store provides insights into store performance and customer spending patterns, allowing for data-driven decision making in areas such as store operation and management.

- [Home](#sakila-sample-database-analysis)

### 7. Store Total Rentals and Average Rentals per Customer

- [Query file](./store_total_rentals_and_avg_rentals_per_customer.sql)
- **Technical explanation**: Calculates the total number of rentals and average number of rentals per customer for each store by joining the `customer`, `rental`, and `inventory` tables. This query groups the results by `store_id` and uses the `COUNT` and `AVG` functions to aggregate the total rentals and average rentals per customer, respectively.
- **Why is this the best approach?**: The query efficiently calculates the total number of rentals and average number of rentals per customer for each store using a simple join and aggregation strategy. This results in optimized execution time and resource utilization.
- **Business case**: Comparing the total rentals and average rentals per customer of each store provides insights into store performance and customer engagement, allowing for data-driven decision making in areas such as store operation and management.

- [Home](#sakila-sample-database-analysis)

### 8. Top 5 Popular Categories per Store

- [Query file](./top_5_popular_categories_per_store.sql)
- **Technical explanation**: Finds the top 5 most popular film categories for each store by joining the `rental`, `inventory`, `film`, `film_category`, and `category` tables. This query uses a CTE along with the `RANK()` window function to rank the categories per store based on rental count and selects the top 5 categories for each store.
- **Why is this the best approach?**: The use of a CTE and the `RANK()` window function allows for efficient and clean code. By ranking categories per store based on rental count and selecting the top 5 categories, the query efficiently identifies the most popular film categories for each store.
- **Business case**: Identifying the top 5 popular film categories for each store can help understand local preferences and trends, allowing for better inventory management and targeted marketing efforts.

- [Home](#sakila-sample-database-analysis)

### 9. Top 10 Customers per Store

- [Query file](./top_10_customers_per_store.sql)
- **Technical explanation**: Determines the top 10 customers with the highest rental count per store by joining the `customer`, `rental`, and `inventory` tables. This query uses a CTE along with the `RANK()` window function to rank customers per store based on rental count and selects the top 10 customers for each store.
- **Why is this the best approach?**: The use of a CTE and the `RANK()` window function allows for efficient and clean code. By ranking customers per store based on rental count and selecting the top 10 customers, the query efficiently identifies the most engaged customers for each store.
- **Business case**:Identifying the top 10 customers per store based on rental count can help target highly engaged customers for loyalty programs, special offers, or personalized marketing campaigns.

- [Home](#sakila-sample-database-analysis)

### 10. Top 10 Overall Customers

- [Query file](./top_10_overall_customers.sql)
- **Technical explanation**: Determines the top 10 customers with the highest rental count overall by joining the `customer` and `rental` tables. This query groups the results by `customer_id`, first name, and last name, and uses the `COUNT` function to aggregate the rental count. The query then selects the top 10 overall customers based on the rental count in descending order.
- **Why is this the best approach?**: The query efficiently calculates the top 10 overall customers based on rental count using a simple join and aggregation strategy. This results in optimized execution time and resource utilization.
- **Business case**: Identifying the top 10 overall customers based on rental count can help target highly engaged customers for loyalty programs, special offers, or personalized marketing campaigns on a broader scale.

- [Home](#sakila-sample-database-analysis)

### 11. Top 10 customers who spend the most per store

- [Query file](./top_10_customers_most_spent_per_store.sql)
- **Technical explanation**: This query retrieves the top 10 customers who spent the most in each store. It uses inner joins to connect the `customer`, `rental`, `payment`, and `store` tables. It then groups the results by `store_id` and `customer_id`, and sorts them in descending order based on the sum of the `payment.amount` column. The query also makes use of a window function `RANK()` to rank customers within each store based on their spending.
- **Why is this the best approach?**: The query uses inner joins to filter out rows that don't have corresponding records in the other tables, improving performance. The window function `RANK()` assigns a rank to each customer within each store based on their spending, allowing the query to easily identify the top 10 customers per store. The `HAVING` clause filters the results to include only the top 10 customers per store.
- **Business case**: This query can help the company identify its top customers in terms of spending at each store location. This information can be used to target marketing campaigns, offer localized promotions, or provide personalized services to high-value customers in specific store locations.

- [Home](#sakila-sample-database-analysis)

### 12. Top 10 customers who spend the most overall

- [Query file](./top_10_customers_who_spend_the_most_overall.sql)
- **Technical explanation**: This query retrieves the top 10 customers who spent the most across all stores. It uses inner joins to connect the `customer`, `rental`, and `payment` tables. It then groups the results by `customer_id` and sorts them in descending order based on the sum of the `payment.amount` column.
- **Why is this the best approach?**: The query uses inner joins to filter out rows that don't have corresponding records in the other tables, which improves performance. The aggregation function `SUM()` calculates the total amount spent by each customer, and the `ORDER BY` clause sorts the results based on this value. The `LIMIT` clause then ensures that only the top 10 customers are returned.
- **Business case**: This query can help the company identify its top customers in terms of spending, allowing them to tailor marketing campaigns, offer targeted promotions, or provide personalized services to these high-value customers.

- [Home](#sakila-sample-database-analysis)

## Usage

To use these queries, download the Sakila Sample Database and load it into your preferred SQL database server. You can then execute the queries against the Sakila database. Be sure to adjust the queries as needed to match your database's syntax and requirements.

## License

This project is licensed under the MIT License.