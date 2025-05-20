-- Actors who have appeared in more than 10 films
-- Improved query with consistent formatting and optimized structure
SELECT 
  a.actor_id,
  a.first_name,
  a.last_name,
  COUNT(fa.film_id) AS film_count
FROM 
  actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
  a.actor_id,
  a.first_name,
  a.last_name
HAVING 
  film_count > 10
ORDER BY 
  film_count DESC;
