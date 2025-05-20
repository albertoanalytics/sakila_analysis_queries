-- Film rating vs. rental performance
-- Analyzes the relationship between film ratings and rental performance
WITH film_rating_metrics AS (
  SELECT
    f.rating,
    COUNT(DISTINCT f.film_id) AS film_count,
    COUNT(DISTINCT i.inventory_id) AS inventory_count,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_revenue
  FROM
    film f
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    f.rating
)

SELECT
  rating,
  film_count,
  inventory_count,
  rental_count,
  ROUND(total_revenue, 2) AS total_revenue,
  ROUND(inventory_count / film_count, 2) AS avg_inventory_per_film,
  ROUND(rental_count / film_count, 2) AS avg_rentals_per_film,
  ROUND(rental_count / inventory_count, 2) AS rentals_per_inventory_item,
  ROUND(total_revenue / film_count, 2) AS avg_revenue_per_film,
  ROUND(total_revenue / rental_count, 2) AS avg_revenue_per_rental,
  ROUND(100 * (rental_count / SUM(rental_count) OVER ()), 2) AS pct_of_total_rentals,
  ROUND(100 * (total_revenue / SUM(total_revenue) OVER ()), 2) AS pct_of_total_revenue
FROM
  film_rating_metrics
ORDER BY
  avg_revenue_per_film DESC;
