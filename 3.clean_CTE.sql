WITH actor_cnt AS(
    SELECT
        film_id,
        count(*) AS ac
    FROM
        film_actor fa
    GROUP BY
        fa.film_id
),
sum_amount_itch AS(
    SELECT
        sum(p.amount) AS sum_a,
        i.film_id
    FROM
        inventory i
        JOIN rental r ON i.inventory_id = r.inventory_id
        JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY
        i.film_id
),
all_films AS(
    SELECT
        sum(p2.amount) AS all_amounts
    FROM
        payment p2
)
SELECT
    f.title,
    coalesce(ac, 0) AS actor_films,
    coalesce(sa.sum_a, 0) AS sum_w_null,
    all_amounts,
    (sa.sum_a / all_amounts) * 100 AS prosent
FROM
    film f
    LEFT JOIN actor_cnt ac ON f.film_id = ac.film_id
    LEFT JOIN sum_amount_itch sa ON f.film_id = sa.film_id
    CROSS JOIN all_films af
ORDER BY
    sum_w_null DESC