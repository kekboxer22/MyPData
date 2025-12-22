
   1.EXCEPT — high revenue films excluding G rating

SELECT
    f.title,
    f.rating
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY f.title, f.rating
HAVING SUM(p.amount) > 150

EXCEPT

SELECT
    title,
    rating
FROM film
WHERE rating = 'G';



   2.  INTERSECT — high revenue films with G rating


SELECT
    f.title,
    f.rating
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY f.title, f.rating
HAVING SUM(p.amount) > 150

INTERSECT

SELECT
    title,
    rating
FROM film
WHERE rating = 'G';
