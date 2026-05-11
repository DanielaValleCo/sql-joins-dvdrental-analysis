\# Data Notes



\## Descripción general de la base



La base de datos \*\*DVD Rental\*\* es una base relacional de ejemplo para PostgreSQL que simula la operación de una empresa de renta de películas.



El modelo contiene información sobre clientes, películas, rentas, pagos, inventario, tiendas, empleados, actores, categorías y ubicaciones geográficas. Debido a que la información está distribuida en varias tablas relacionadas, esta base es útil para practicar consultas SQL con `JOIN`, agregaciones, subconsultas y operaciones de conjuntos.



El objetivo de este proyecto fue analizar la base desde una perspectiva de negocio, respondiendo preguntas relacionadas con clientes, ingresos, catálogo, inventario, rentabilidad y calidad de datos.



\---



\## Tipo de modelo



La base DVD Rental utiliza un \*\*modelo relacional normalizado\*\*. Esto significa que la información no está concentrada en una sola tabla, sino separada en diferentes entidades conectadas mediante llaves primarias y llaves foráneas.



Por ejemplo, el país de un cliente no se encuentra directamente en la tabla `customer`. Para obtenerlo, es necesario recorrer la siguiente relación:



```sql

customer → address → city → country

```



De forma similar, para analizar las rentas por categoría de película, es necesario unir varias tablas:



```sql

category → film\_category → inventory → rental

```



Y para analizar ingresos por categoría, se agrega la tabla `payment`:



```sql

category → film\_category → inventory → rental → payment

```



Este diseño permite evitar duplicidad de información y representa de forma más realista cómo suelen estructurarse las bases de datos transaccionales.



\---



\## Tablas principales



\### `customer`



Contiene información de los clientes registrados en la empresa.



Campos relevantes:



\- `customer\_id`: identificador único del cliente.

\- `store\_id`: tienda asociada al cliente.

\- `first\_name`: nombre del cliente.

\- `last\_name`: apellido del cliente.

\- `email`: correo electrónico del cliente.

\- `address\_id`: dirección asociada al cliente.

\- `active`: indica si el cliente está activo.



Esta tabla fue utilizada para analizar distribución de clientes, clientes con mayor ingreso generado y clientes con o sin rentas asociadas.



\---



\### `payment`



Contiene los pagos realizados por los clientes.



Campos relevantes:



\- `payment\_id`: identificador único del pago.

\- `customer\_id`: cliente que realizó el pago.

\- `staff\_id`: empleado que procesó el pago.

\- `rental\_id`: renta asociada al pago.

\- `amount`: monto pagado.

\- `payment\_date`: fecha del pago.



Esta tabla fue clave para calcular ingresos totales, ingresos por país, ingresos por cliente, ingresos por categoría e ingresos por tienda.



\---



\### `rental`



Contiene los registros de renta de películas.



Campos relevantes:



\- `rental\_id`: identificador único de la renta.

\- `rental\_date`: fecha de la renta.

\- `inventory\_id`: copia de inventario rentada.

\- `customer\_id`: cliente que realizó la renta.

\- `return\_date`: fecha de devolución.

\- `staff\_id`: empleado asociado a la renta.



Esta tabla permitió medir demanda, frecuencia de rentas, películas más rentadas y categorías más rentadas.



\---



\### `inventory`



Contiene las copias disponibles de películas en cada tienda.



Campos relevantes:



\- `inventory\_id`: identificador único de la copia en inventario.

\- `film\_id`: película asociada.

\- `store\_id`: tienda donde se encuentra la copia.



Esta tabla fue utilizada para conectar películas con rentas y tiendas. También permitió analizar cobertura de inventario por tienda y categoría.



\---



\### `film`



Contiene el catálogo de películas.



Campos relevantes:



\- `film\_id`: identificador único de la película.

\- `title`: título de la película.

\- `description`: descripción de la película.

\- `release\_year`: año de lanzamiento.

\- `language\_id`: idioma de la película.

\- `rental\_duration`: duración de renta.

\- `rental\_rate`: tarifa de renta.

\- `length`: duración de la película.

\- `replacement\_cost`: costo de reemplazo.

\- `rating`: clasificación.



Esta tabla fue utilizada para analizar películas más rentadas, películas sin rentas y películas sin actores asociados.



\---



\### `category`



Contiene las categorías o géneros de películas.



Campos relevantes:



\- `category\_id`: identificador único de la categoría.

\- `name`: nombre de la categoría.



Esta tabla fue utilizada para analizar categorías más rentadas, categorías con mayores ingresos, categorías sin rentas y categorías estratégicas en demanda y rentabilidad.



\---



\### `film\_category`



Es una tabla puente que conecta películas con categorías.



Campos relevantes:



\- `film\_id`: identificador de la película.

\- `category\_id`: identificador de la categoría.



Esta tabla permite resolver la relación entre `film` y `category`.



\---



\### `actor`



Contiene información de los actores.



Campos relevantes:



\- `actor\_id`: identificador único del actor.

\- `first\_name`: nombre del actor.

\- `last\_name`: apellido del actor.



\---



\### `film\_actor`



Es una tabla puente que conecta películas con actores.



Campos relevantes:



\- `actor\_id`: identificador del actor.

\- `film\_id`: identificador de la película.



Esta tabla fue utilizada para detectar películas del catálogo sin actores asociados.



\---



\### `store`



Contiene información de las tiendas.



Campos relevantes:



\- `store\_id`: identificador único de la tienda.

\- `manager\_staff\_id`: empleado encargado de la tienda.

\- `address\_id`: dirección de la tienda.



Esta tabla fue utilizada para analizar inventario por tienda y categorías disponibles en cada sucursal.



\---



\### `staff`



Contiene información de los empleados.



Campos relevantes:



\- `staff\_id`: identificador único del empleado.

\- `first\_name`: nombre del empleado.

\- `last\_name`: apellido del empleado.

\- `address\_id`: dirección del empleado.

\- `store\_id`: tienda asociada.

\- `active`: estado del empleado.



Esta tabla puede utilizarse para analizar desempeño operativo, pagos procesados e ingresos por empleado.



\---



\### `address`



Contiene direcciones asociadas a clientes, tiendas y empleados.



Campos relevantes:



\- `address\_id`: identificador único de la dirección.

\- `address`: dirección.

\- `district`: distrito.

\- `city\_id`: ciudad asociada.

\- `postal\_code`: código postal.

\- `phone`: teléfono.



\---



\### `city`



Contiene las ciudades registradas en la base.



Campos relevantes:



\- `city\_id`: identificador único de la ciudad.

\- `city`: nombre de la ciudad.

\- `country\_id`: país asociado.



\---



\### `country`



Contiene los países registrados en la base.



Campos relevantes:



\- `country\_id`: identificador único del país.

\- `country`: nombre del país.



Esta tabla fue utilizada para analizar distribución geográfica de clientes e ingresos por país.



\---



\### `language`



Contiene los idiomas de las películas.



Campos relevantes:



\- `language\_id`: identificador único del idioma.

\- `name`: nombre del idioma.



\---



\## Relaciones importantes



Las principales relaciones utilizadas durante el análisis fueron:



```sql

customer.address\_id → address.address\_id

address.city\_id → city.city\_id

city.country\_id → country.country\_id

customer.store\_id → store.store\_id

store.address\_id → address.address\_id

rental.customer\_id → customer.customer\_id

rental.inventory\_id → inventory.inventory\_id

inventory.film\_id → film.film\_id

inventory.store\_id → store.store\_id

payment.customer\_id → customer.customer\_id

payment.rental\_id → rental.rental\_id

payment.staff\_id → staff.staff\_id

film\_category.film\_id → film.film\_id

film\_category.category\_id → category.category\_id

film\_actor.film\_id → film.film\_id

film\_actor.actor\_id → actor.actor\_id

film.language\_id → language.language\_id

```



\---



\## Rutas de análisis utilizadas



\### Clientes por país



Para conocer la ubicación geográfica de los clientes se utilizó la ruta:



```sql

customer → address → city → country

```



Esta ruta permitió contar clientes por país e identificar mercados con mayor concentración de usuarios.



\---



\### Ingresos por país



Para calcular ingresos por país se utilizó la ruta:



```sql

payment → customer → address → city → country

```



Esto permitió identificar qué países generan mayores ingresos totales y comparar esos resultados contra la distribución de clientes.



\---



\### Ingreso promedio por cliente y país



Para calcular el ingreso promedio por cliente se combinaron ingresos y número de clientes únicos por país:



```sql

payment → customer → address → city → country

```



La métrica calculada fue:



```sql

SUM(payment.amount) / COUNT(DISTINCT customer.customer\_id)

```



Esta métrica permitió distinguir entre mercados con muchos clientes y mercados con clientes de mayor valor promedio.



\---



\### Categorías más rentadas



Para analizar la demanda por categoría se utilizó la ruta:



```sql

category → film\_category → inventory → rental

```



Esta ruta permitió contar cuántas rentas están asociadas a cada categoría.



\---



\### Ingresos por categoría



Para analizar rentabilidad por género se utilizó la ruta:



```sql

category → film\_category → inventory → rental → payment

```



Esto permitió calcular ingresos totales por categoría y comparar popularidad contra rentabilidad.



\---



\### Películas más rentadas



Para identificar títulos con mayor demanda se utilizó la ruta:



```sql

film → inventory → rental

```



Esto permitió contar cuántas veces fue rentada cada película.



\---



\### Películas sin actores asociados



Para detectar registros incompletos del catálogo se utilizó:



```sql

film → film\_actor

```



Mediante un `LEFT JOIN`, se identificaron películas sin coincidencia en la tabla `film\_actor`.



\---



\### Inventario por tienda y categoría



Para evaluar la cobertura de inventario se utilizó una matriz tienda-categoría generada con `CROSS JOIN`:



```sql

store CROSS JOIN category

```



Posteriormente, se comparó contra el inventario real mediante:



```sql

category → film\_category → inventory

```



Esto permitió verificar si cada tienda tenía inventario en todas las categorías.



\---



\## Técnicas SQL utilizadas



Durante el proyecto se utilizaron diferentes técnicas SQL:



\### `INNER JOIN`



Se utilizó para combinar tablas cuando solo interesaban registros con coincidencias en ambas tablas.



Ejemplos de uso:



\- Clientes con país.

\- Pagos con clientes.

\- Rentas con películas.

\- Categorías con rentas.



\---



\### `LEFT JOIN`



Se utilizó para conservar todos los registros de una tabla principal y detectar ausencias en una tabla relacionada.



Ejemplos de uso:



\- Clientes sin rentas asociadas.

\- Películas sin actores registrados.

\- Matriz tienda-categoría comparada contra inventario real.



\---



\### `CROSS JOIN`



Se utilizó para generar todas las combinaciones posibles entre tiendas y categorías.



Este enfoque permitió construir una matriz completa de análisis para evaluar la cobertura del inventario.



\---



\### `EXCEPT`



Se utilizó para comparar conjuntos y encontrar elementos presentes en un conjunto pero ausentes en otro.



Ejemplos de uso:



\- Categorías del catálogo sin rentas.

\- Películas del catálogo que nunca fueron rentadas.

\- Películas con inventario que nunca fueron rentadas.



\---



\### `INTERSECT`



Se utilizó para encontrar coincidencias entre dos conjuntos de resultados.



Ejemplo de uso:



\- Categorías que están tanto en el top de rentas como en el top de ingresos.



\---



\### Agregaciones



Se utilizaron funciones de agregación para construir métricas de negocio:



```sql

COUNT()

SUM()

AVG()

```



También se utilizaron:



```sql

GROUP BY

ORDER BY

LIMIT

```



\---



\## Consideraciones sobre los datos



La base DVD Rental utiliza datos ficticios con fines educativos. Por esta razón:



\- Los títulos de películas no necesariamente corresponden a películas reales.

\- Los nombres de clientes, países y operaciones forman parte de un escenario de práctica.

\- Algunos resultados deben interpretarse como parte de una simulación de negocio.

\- A pesar de ser una base de ejemplo, el modelo relacional permite practicar escenarios comunes de análisis de datos en empresas reales.



\---



\## Consideraciones analíticas



Durante el análisis se procuró no interpretar los resultados de forma aislada. Algunas consultas fueron utilizadas para validar resultados anteriores.



Por ejemplo:



\- Se identificaron 42 películas del catálogo sin rentas asociadas.

\- Después se verificó si esas películas tenían copias en inventario.

\- Al restringir el análisis a películas con inventario disponible, el resultado fue 0 películas sin renta.



Esto cambió la interpretación inicial: las películas sin renta no necesariamente indican baja demanda, sino que probablemente no tenían unidades disponibles para ser rentadas.



Este tipo de validación es importante en análisis de datos, ya que evita conclusiones incorrectas basadas en una sola consulta.



\---



\## Archivos relacionados



\- `README.md`: contiene la descripción del proyecto, preguntas de negocio, resultados principales e insights.

\- `queries.sql`: contiene las consultas SQL utilizadas.

\- `setup\_database.md`: documenta el proceso de descarga, carga y restauración de la base en PostgreSQL.

\- `images/`: contiene el diagrama entidad-relación de la base.

\- `results/`: contiene los resultados exportados de algunas consultas.



\---



\## Conclusión sobre el modelo de datos



DVD Rental es una base adecuada para practicar análisis relacional porque obliga a conectar múltiples tablas para responder preguntas de negocio.



El proyecto permitió trabajar con rutas relacionales complejas, validar datos faltantes, comparar conjuntos y generar métricas relacionadas con clientes, ingresos, categorías, películas e inventario.



Este tipo de análisis refleja tareas comunes en roles de análisis de datos, inteligencia de negocios y reporting, donde las preguntas de negocio rara vez se responden desde una sola tabla.

