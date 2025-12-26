
---   Revenue classification using CASE

SELECT
    f.title,
    SUM(p.amount) AS total_amount,
    CASE
        WHEN SUM(p.amount) >= 150 THEN 'Top'
        WHEN SUM(p.amount) >= 100 THEN 'Mid'
        ELSE 'Low'
    END AS revenue_category
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY f.title;
