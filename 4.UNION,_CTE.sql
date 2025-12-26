WITH without_g AS(
SELECT
    f.title,
    f.film_id,
    f.rating,
    sum(p.amount) AS total_rev
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY
f.film_id,
f.rating
HAVING 
SUM(p.amount) > 100)
SELECT
    wg.title,
    wg.rating,
    total_rev,
    'g rating' AS categoey
FROM
    without_g wg
WHERE
    rating = 'G'
UNION ALL      
SELECT
    wg.title,
    wg.rating,
    total_rev,
    'non g rating' AS category
FROM
    without_g wg
WHERE
    rating <> 'G'
ORDER BY
    total_rev DESC
