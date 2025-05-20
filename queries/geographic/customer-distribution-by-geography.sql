-- Customer distribution by geography
-- Analyzes the geographical distribution of customers across countries and cities
WITH customer_geo AS (
  SELECT
    co.country_id,
    co.country,
    ci.city_id,
    ci.city,
    COUNT(cu.customer_id) AS customer_count
  FROM
    customer cu
    JOIN address a ON cu.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
  GROUP BY
    co.country_id,
    co.country,
    ci.city_id,
    ci.city
),

country_totals AS (
  SELECT
    country_id,
    country,
    SUM(customer_count) AS country_customer_count
  FROM
    customer_geo
  GROUP BY
    country_id,
    country
)

SELECT
  cg.country,
  cg.city,
  cg.customer_count,
  ct.country_customer_count,
  ROUND(100 * (cg.customer_count / ct.country_customer_count), 2) AS pct_of_country_customers,
  ROUND(100 * (cg.customer_count / SUM(cg.customer_count) OVER ()), 2) AS pct_of_total_customers,
  RANK() OVER (PARTITION BY cg.country ORDER BY cg.customer_count DESC) AS rank_in_country,
  RANK() OVER (ORDER BY cg.customer_count DESC) AS overall_rank
FROM
  customer_geo cg
  JOIN country_totals ct ON cg.country_id = ct.country_id
ORDER BY
  cg.customer_count DESC,
  cg.country,
  cg.city;
