
    CTE ANALYTICS — FILM REVENUE & ACTOR COVERAGE
    Database: DVD Rental
    Goal:
 - Count actors per film
 - Calculate revenue per film
 - Calculate total global revenue
- Show % each film contributes to total income
- Return ranked analytic output
    Author: (Naumchenko Mykyta)

-- CTE #1 — count how many actors pre each film

WITH actor_cnt AS (
    SELECT
        film_id,
        COUNT(*) AS actor_count
    FROM film_actor
    GROUP BY film_id
)
-- Description:
-- 1 film_id → X actors
-- Builds a dataset to show how "large" a cast each movie has.


-- CTE #2 — sum per film

, film_revenue AS (
    SELECT
        i.film_id,
        SUM(p.amount) AS revenue
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY i.film_id
)
-- Description:
-- For each film we calculate total revenue earned.


--CTE #3 — total revenue for database

, total_revenue AS (
    SELECT
        SUM(amount) AS global_revenue
    FROM payment
)
-- Description:
-- Single-row table → one number used for percentage math.

-- FINAL
SELECT
    f.title,
    COALESCE(a.actor_count, 0) AS actors_in_film,
    COALESCE(r.revenue, 0) AS film_revenue,
    t.global_revenue,
    ROUND(COALESCE(r.revenue, 0) / t.global_revenue * 100, 2) AS revenue_share_percent
FROM film f
LEFT JOIN actor_cnt a ON f.film_id = a.film_id
LEFT JOIN film_revenue r ON f.film_id = r.film_id
CROSS JOIN total_revenue t
ORDER BY revenue_share_percent DESC;

-- Description:
-- Final joined view:
--  - every film
--  - number of actors
--  - revenue
--  - % contribution to total database revenue
--  Sorted to show the most profitable films first.
