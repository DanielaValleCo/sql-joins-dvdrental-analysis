/* ============================================================
   SQL Joins Business Analysis - DVD Rental
   Author: Daniela Valle
   Database: dvdrental
   Tool: PostgreSQL + pgAdmin
   ============================================================ */


/* ------------------------------------------------------------
   Pregunta 1:
   Nos interesa determinar en qué países se encuentran nuestros
   clientes y cuántos clientes hay por país. (categoría de ingresos
   por país)
   ------------------------------------------------------------ */
SELECT COUNT(customer_id), country
FROM customer
INNER JOIN address 
USING(address_id)
INNER JOIN city 
USING (city_id)
INNER JOIN country 
USING(country_id)
GROUP BY country
ORDER BY COUNT(customer_id) DESC;


/* ------------------------------------------------------------
   Pregunta 2: 
   Nos interesa identificar a los clientes que más 
   ingresos han generado para la empresa. (clientes con mayor valor)
   ------------------------------------------------------------ */

SELECT customer_id, first_name, last_name, SUM(amount)
FROM customer
INNER JOIN payment
USING (customer_id)
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 10;

/* ------------------------------------------------------------
   Pregunta 3: 
   Nos interesa determinar qué países generan mayores
   ingresos totales por rentas
   ------------------------------------------------------------ */

SELECT SUM(amount) revenue_por_country, country
FROM payment
INNER JOIN customer
USING(customer_id)
INNER JOIN address
USING (address_id)
INNER JOIN city
USING(city_id)
INNER JOIN country
USING(country_id)
GROUP BY country
ORDER BY SUM(amount) DESC;



/* ------------------------------------------------------------
   Pregunta 4:
   Nos interesa identificar qué países generan mayor ingreso
   promedio por cliente, para detectar mercados que quizá no
   tienen tantos clientes, pero sí clientes más valiosos.
   ------------------------------------------------------------ */

SELECT
    co.country,
    COUNT(DISTINCT cu.customer_id) AS total_customers,
    SUM(p.amount) AS total_revenue,
    ROUND(SUM(p.amount) / COUNT(DISTINCT cu.customer_id), 2) AS revenue_per_customer
FROM payment AS p
INNER JOIN customer AS cu
    USING(customer_id)
INNER JOIN address AS a
    USING(address_id)
INNER JOIN city AS ci
    USING(city_id)
INNER JOIN country AS co
    USING(country_id)
GROUP BY co.country
ORDER BY revenue_per_customer DESC;


/* ------------------------------------------------------------
   Pregunta 5: 
   Nos interesa identificar qué categorías de películas
   son las más rentadas por clientes
 ------------------------------------------------------------ */
SELECT COUNT(rental_id) AS num_rentas, t1.category_id, t1.name
FROM category AS t1
INNER JOIN film_category AS t2
USING(category_id)
INNER JOIN film AS t3
USING(film_id)
INNER JOIN inventory AS t4
USING(film_id)
INNER JOIN rental AS t5
USING (inventory_id)
GROUP BY category_id
ORDER BY COUNT(rental_id) DESC;

/* ------------------------------------------------------------
   Pregunta 6: 
   Nos interesa identificar qué categorías de películas
   son las que generan más ingresos
 ------------------------------------------------------------ */
SELECT SUM(amount) AS rev_total, t1.category_id, t1.name
FROM category AS t1
INNER JOIN film_category AS t2
USING(category_id)
INNER JOIN film AS t3
USING(film_id)
INNER JOIN inventory AS t4
USING(film_id)
INNER JOIN rental AS t5
USING (inventory_id)
INNER JOIN payment AS t6
USING(rental_id)
GROUP BY category_id
ORDER BY SUM(amount) DESC;

/* ------------------------------------------------------------
   Pregunta 7: 
   Nos interesa identificar cuáles son las películas más rentadas
 ------------------------------------------------------------ */
SELECT film_id, title, COUNT(rental_id)
FROM film
INNER JOIN inventory 
USING(film_id)
INNER JOIN rental 
USING(inventory_id)
GROUP BY film_id
ORDER BY COUNT(rental_id) DESC
LIMIT 10;

/* ------------------------------------------------------------
   Pregunta 8: 
   Clientes registrados sin rentas
 ------------------------------------------------------------ */
SELECT customer_id, first_name, last_name, rental_id
FROM customer
LEFT JOIN rental
USING(customer_id)
WHERE rental_id IS NULL;

SELECT COUNT(*) AS clientes_sin_rentas
FROM customer AS c
LEFT JOIN rental AS r
    USING(customer_id)
WHERE r.rental_id IS NULL;


/* ------------------------------------------------------------
Pregunta 9
Nos interesa identificar películas que no tienen actores
asociados en la base
------------------------------------------------------------ */

SELECT f.film_id, f.title AS films_without_actors_inbase
FROM film AS f
LEFT JOIN film_actor 
USING(film_id)
WHERE film_actor IS NULL;



/* ------------------------------------------------------------
Pregunta 10
Nos interesa construir una matriz completa de tiendas y categorías para evaluar si cada 
tienda cuenta con inventario en todos los generos disponibles
------------------------------------------------------------ */
SELECT 
    s.store_id,
    c.category_id,
    c.name AS category_name,
    COUNT(i.inventory_id) AS total_inventory
FROM store AS s
CROSS JOIN category AS c
LEFT JOIN film_category AS fc
    ON c.category_id = fc.category_id
LEFT JOIN inventory AS i
    ON fc.film_id = i.film_id
    AND s.store_id = i.store_id
GROUP BY 
    s.store_id,
    c.category_id,
    c.name
ORDER BY 
    s.store_id,
    c.category_id;



/* ------------------------------------------------------------
Pregunta 11:
Nos interesa identificar si existen categorías en el catálogo que no hayan 
tenido ninguna renta
------------------------------------------------------------ */
SELECT category_id, name
FROM category
EXCEPT 
SELECT category_id, name
FROM category
INNER JOIN film_category
USING(category_id)
INNER JOIN film
USING(film_id)
INNER JOIN inventory
USING(film_id)
INNER JOIN rental
USING(inventory_id);



/* ------------------------------------------------------------
Pregunta 12:
Peliculas disponibles en el catálogo que nunca han sido rentadas
para detectar inventario sin rotación
TODAS LAS PELICULAS DE FILM MENOS PELÍCULAS RENTADAS =
PELICULAS DEL CATÁLOGO SIN RENTAS
------------------------------------------------------------ */
 SELECT film_id, title
 FROM film
 EXCEPT
 SELECT film_id, title
 FROM film
 INNER JOIN inventory
 USING(film_id )
 INNER JOIN rental
 USING(inventory_id);


/* ------------------------------------------------------------
Pregunta 13:
La consulta anterior parte de las películas registradas en "film" 
por lo que una película sin rentas puede deberse a una baja demanda
pero también a que no tenga copias disponibles en inventario
Un siguiente paso util sería verificar si estas películas cuentan con 
unidades registradas en 'inventory'.
PELICULAS QUE SÍ ESTAN EN INVENTORY MENOS PELÍCULAS RENTADAS=
PELICULAS EN INVENTARIO SIN RENTAS
------------------------------------------------------------ */
SELECT film_id, title
 FROM film
 INNER JOIN inventory
  USING(film_id)
EXCEPT
SELECT film_id, title
 FROM film
 INNER JOIN inventory
  USING(film_id )
 INNER JOIN rental
  USING(inventory_id);


/* ------------------------------------------------------------
Pregunta 14:
Nos interesa identificar categorías que estén dentro del top de 
categorías más rentadas y también dentro del top de categorías
con mayores ingresos. Génetos fuertes tanto en demanda como en 
rentabilidad
------------------------------------------------------------ */

SELECT category_id, name
FROM
(SELECT category_id, name, COUNT(DISTINCT rental_id) AS num_rentas
FROM category
INNER JOIN film_category
USING(category_id)
INNER JOIN inventory
USING(film_id)
INNER JOIN rental
USING(inventory_id)
GROUP BY category_id, name
ORDER BY num_rentas DESC
LIMIT 10) AS subquerie_rentas
	INTERSECT
SELECT category_id, name
FROM
(SELECT category_id, name, SUM(amount) AS mayores_ingresos
FROM category
INNER JOIN film_category
USING(category_id)
INNER JOIN inventory
USING(film_id)
INNER JOIN rental
USING(inventory_id)
INNER JOIN payment
USING(rental_id)
GROUP BY category_id, name
ORDER BY mayores_ingresos DESC
LIMIT 10) AS subquerie_ingreso;