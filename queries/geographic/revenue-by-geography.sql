-- Revenue by country and city
-- Analyzes the geographical distribution of revenue
WITH customer_geo_revenue AS (
  SELECT
    co.country_id,
    co.country,
    ci.city_id,
    ci.city,
    COUNT(DISTINCT cu.customer_id) AS customer_count,
    COUNT(p.payment_id) AS payment_count,
    SUM(p.amount) AS total_revenue
  FROM
    payment p
    JOIN customer cu ON p.customer_id = cu.customer_id
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
    SUM(customer_count) AS country_customer_count,
    SUM(total_revenue) AS country_revenue
  FROM
    customer_geo_revenue
  GROUP BY
    country_id,
    country
)

SELECT
  cgr.country,
  cgr.city,
  cgr.customer_count,
  ROUND(cgr.total_revenue, 2) AS total_revenue,
  ROUND(cgr.total_revenue / cgr.customer_count, 2) AS revenue_per_customer,
  ROUND(cgr.payment_count / cgr.customer_count, 2) AS payments_per_customer,
  ROUND(cgr.total_revenue / cgr.payment_count, 2) AS avg_payment_amount,
  ROUND(100 * (cgr.total_revenue / ct.country_revenue), 2) AS pct_of_country_revenue,
  ROUND(100 * (cgr.total_revenue / SUM(cgr.total_revenue) OVER ()), 2) AS pct_of_total_revenue,
  RANK() OVER (PARTITION BY cgr.country ORDER BY cgr.total_revenue DESC) AS revenue_rank_in_country,
  RANK() OVER (ORDER BY cgr.total_revenue DESC) AS overall_revenue_rank
FROM
  customer_geo_revenue cgr
  JOIN country_totals ct ON cgr.country_id = ct.country_id
ORDER BY
  cgr.total_revenue DESC,
  cgr.country,
  cgr.city;
