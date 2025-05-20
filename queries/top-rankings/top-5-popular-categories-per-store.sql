-- Top 5 most popular film categories for each store
-- Improved query with consistent formatting, enhanced readability, and store address
WITH store_category_rentals AS (
  SELECT
    s.store_id,
    a.address AS store_address,
    ci.city AS store_city,
    c.category_id,
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count
  FROM
    rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN store s ON i.store_id = s.store_id
    JOIN address a ON s.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
  GROUP BY
    s.store_id,
    a.address,
    ci.city,
    c.category_id,
    c.name
),

store_category_rentals_ranked AS (
  SELECT
    store_id,
    store_address,
    store_city,
    category_id,
    category_name,
    rental_count,
    RANK() OVER (PARTITION BY store_id ORDER BY rental_count DESC) AS rental_rank
  FROM
    store_category_rentals
)

SELECT
  store_id,
  store_address,
  store_city,
  category_name,
  rental_count,
  rental_rank
FROM
  store_category_rentals_ranked
WHERE
  rental_rank <= 5
ORDER BY
  store_id,
  rental_rank;
