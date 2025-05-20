-- Film profitability analysis
-- Analyzes the profitability of films based on rental revenue vs. replacement cost
WITH film_revenue AS (
  SELECT
    f.film_id,
    f.title,
    f.release_year,
    f.rental_rate,
    f.replacement_cost,
    f.rating,
    c.name AS category,
    COUNT(DISTINCT i.inventory_id) AS inventory_count,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_revenue
  FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    f.film_id,
    f.title,
    f.release_year,
    f.rental_rate,
    f.replacement_cost,
    f.rating,
    c.name
)

SELECT
  film_id,
  title,
  release_year,
  category,
  rating,
  rental_rate,
  replacement_cost,
  inventory_count,
  rental_count,
  ROUND(total_revenue, 2) AS total_revenue,
  ROUND(total_revenue / rental_count, 2) AS avg_revenue_per_rental,
  ROUND(replacement_cost * inventory_count, 2) AS total_inventory_cost,
  ROUND(total_revenue - (replacement_cost * inventory_count), 2) AS profit,
  ROUND(
    (total_revenue - (replacement_cost * inventory_count)) / (replacement_cost * inventory_count) * 100,
    2
  ) AS roi_percentage,
  -- Breakeven calculation
  CEIL(replacement_cost / rental_rate) AS rentals_to_breakeven,
  CASE
    WHEN rental_count >= CEIL(replacement_cost / rental_rate) THEN 'Profitable'
    ELSE 'Not Yet Profitable'
  END AS profit_status
FROM
  film_revenue
ORDER BY
  roi_percentage DESC;
