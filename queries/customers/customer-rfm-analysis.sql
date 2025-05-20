-- Customer RFM (Recency, Frequency, Monetary) Analysis
-- Segments customers based on their purchasing behavior
WITH customer_rfm AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.create_date AS customer_since,
    DATEDIFF(CURRENT_DATE, MAX(r.rental_date)) AS recency,
    COUNT(r.rental_id) AS frequency,
    SUM(p.amount) AS monetary,
    MAX(r.rental_date) AS last_rental,
    MIN(r.rental_date) AS first_rental
  FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.create_date
),

rfm_scores AS (
  SELECT
    customer_id,
    first_name,
    last_name,
    email,
    customer_since,
    recency,
    frequency,
    monetary,
    last_rental,
    first_rental,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency) AS f_score,
    NTILE(5) OVER (ORDER BY monetary) AS m_score
  FROM
    customer_rfm
)

SELECT
  customer_id,
  first_name,
  last_name,
  email,
  customer_since,
  last_rental,
  first_rental,
  recency,
  frequency,
  ROUND(monetary, 2) AS monetary,
  r_score,
  f_score,
  m_score,
  CONCAT(r_score, f_score, m_score) AS rfm_score,
  CASE
    WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
    WHEN r_score >= 4 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
    WHEN r_score >= 3 AND f_score >= 1 AND m_score >= 2 THEN 'Potential Loyalists'
    WHEN r_score >= 4 AND f_score >= 1 AND m_score >= 1 THEN 'New Customers'
    WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 2 THEN 'Promising'
    WHEN r_score >= 2 AND f_score >= 2 AND m_score >= 2 THEN 'Needs Attention'
    WHEN r_score >= 2 AND f_score >= 1 AND m_score >= 1 THEN 'About to Sleep'
    WHEN r_score = 1 AND f_score >= 4 AND m_score >= 4 THEN 'At Risk'
    WHEN r_score = 1 AND f_score >= 2 AND m_score >= 2 THEN 'Cannot Lose Them'
    WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'Hibernating'
    WHEN r_score = 1 AND f_score = 1 AND m_score = 1 THEN 'Lost'
    ELSE 'Others'
  END AS customer_segment
FROM
  rfm_scores
ORDER BY
  customer_segment, monetary DESC;
