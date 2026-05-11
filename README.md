\# SQL Joins Business Analysis - DVD Rental



\## Descripción del proyecto



Este proyecto presenta un análisis relacional de la base de datos \*\*DVD Rental\*\*, una base transaccional en PostgreSQL que simula las operaciones de una empresa de renta de películas.



El objetivo fue utilizar consultas SQL con distintos tipos de `JOIN` para responder preguntas de negocio relacionadas con clientes, ingresos, países, tiendas, inventario, categorías de películas y comportamiento de renta.



\## Objetivo



Transformar preguntas de negocio en consultas SQL y generar insights accionables a partir de una base relacional compuesta por múltiples tablas.



\## Herramientas utilizadas



\- PostgreSQL

\- pgAdmin

\- SQL

\- GitHub

\- Markdown



\## Preguntas de negocio



1\. ¿En qué países se concentran nuestros clientes?

2\. ¿Qué clientes han generado mayores ingresos?

3\. ¿Qué países generan más ingresos por renta?

4\. ¿Qué categorías de películas son más rentadas?

5\. ¿Qué categorías generan mayores ingresos?



\### Pregunta 1: ¿En qué países se encuentran nuestros clientes y cuántos clientes hay por país?



Se realizó una consulta utilizando `INNER JOIN` entre las tablas `customer`, `address`, `city` y `country` para identificar la distribución geográfica de los clientes.



\*\*Insight:\*\*

La mayor concentración de clientes se encuentra en India, China y Estados Unidos, con 60, 53 y 36 clientes respectivamente. Esto sugiere que la empresa tiene una base de clientes más fuerte en mercados internacionales específicos, por lo que estos países podrían ser prioritarios para campañas de retención, promociones regionales o análisis más profundo de comportamiento de renta.



\*\*Interpretación de negocio:\*\*

Conocer la concentración geográfica de clientes permite orientar mejor las estrategias comerciales. Por ejemplo, India y China podrían representar mercados clave para fortalecer el catálogo, ajustar campañas de marketing o analizar preferencias de contenido por región.





\###Pregunta 2: ¿Qué clientes han generado mayores ingresos?



\### Objetivo de negocio



Identificar a los clientes con mayor contribución económica para la empresa, con el fin de reconocer clientes de alto valor y posibles candidatos para estrategias de fidelización.



Eleanor Hunt y Karl Seal son los clientes con mayor ingreso acumulado dentro de la base, superando los 200 en pagos totales. El resto de los clientes principales se mantiene en un rango aproximado de 160 a 195, lo que sugiere la existencia de un grupo reducido de clientes con una contribución económica superior al promedio.



Desde una perspectiva de negocio, estos clientes podrían considerarse usuarios de alto valor. La empresa podría diseñar estrategias de fidelización para este segmento, como descuentos personalizados, beneficios por recurrencia o recomendaciones basadas en su historial de rentas.





\###Pregunta 3: Nos interesa determinar qué países generan mayores ingresos

No basta con saber dónde hay más clientes, también importa saber qué países generan más ingresos. Un país con menos clientes podría tener mayor valor promedio por cliente.



India y China lideran la generación de ingresos, al igual que en la distribución de clientes observada previamente. Esto indica que no solo concentran una parte importante de la base de clientes, sino que también representan los mercados con mayor contribución económica.



Estados Unidos, Japón, México y Brasil también aparecen entre los países con mayores ingresos, manteniendo una relación consistente con su volumen de clientes. Esto sugiere que los principales mercados por número de clientes también son relevantes desde una perspectiva de ingresos.



Interpretación de negocio



Este resultado permite priorizar mercados no solo por cantidad de clientes, sino por valor económico generado. India y China podrían considerarse mercados estratégicos para campañas de retención, promociones regionales o análisis de preferencias de contenido. Además, comparar ingresos totales con número de clientes abre la puerta a una métrica más precisa: ingreso promedio por cliente.











\## Pregunta 4: ¿Qué países generan mayor ingreso promedio por cliente?



\### Objetivo de negocio



Identificar qué países generan mayor ingreso promedio por cliente, con el fin de detectar mercados que quizá no concentran una gran cantidad de clientes, pero sí presentan clientes con mayor valor económico individual.



Esta pregunta complementa el análisis de ingresos totales por país, ya que permite distinguir entre mercados grandes por volumen y mercados atractivos por rentabilidad promedio.



\### Resultado principal



Los países con mayor ingreso promedio por cliente fueron:



| País | Clientes | Ingreso total | Ingreso promedio por cliente |

|---|---:|---:|---:|

| Runion | 1 | 211.55 | 211.55 |

| Holy See (Vatican City State) | 1 | 146.68 | 146.68 |

| Nauru | 1 | 143.70 | 143.70 |

| Sweden | 1 | 139.67 | 139.67 |

| Belarus | 2 | 271.36 | 135.68 |

| Thailand | 3 | 401.08 | 133.69 |

| Czech Republic | 1 | 132.72 | 132.72 |

| Moldova | 1 | 127.66 | 127.66 |

| Turkmenistan | 1 | 126.74 | 126.74 |

| Latvia | 2 | 249.43 | 124.72 |



\### Insight



El ranking por ingreso promedio por cliente cambia respecto al análisis de ingresos totales por país. Mientras que países como India, China y United States lideraban en ingresos totales, esta consulta muestra que países con pocos clientes pueden tener un ingreso promedio por cliente más alto.



Por ejemplo, Runion aparece en primer lugar con un solo cliente y un ingreso total de 211.55, lo que también representa su ingreso promedio por cliente. De forma similar, Holy See, Nauru y Sweden aparecen en los primeros lugares debido a que tienen un número muy reducido de clientes, pero con pagos acumulados relativamente altos.



\### Interpretación de negocio



Este análisis permite identificar mercados pequeños pero potencialmente valiosos. Sin embargo, debe interpretarse con cuidado: cuando un país tiene solo uno o dos clientes, el ingreso promedio puede verse inflado por el comportamiento de muy pocos usuarios.



Desde una perspectiva comercial, esta métrica es útil para detectar oportunidades, pero debería complementarse con el número total de clientes y el ingreso total. Un país con alto ingreso promedio pero muy pocos clientes podría representar una oportunidad de expansión, mientras que un país con muchos clientes e ingresos altos podría ser un mercado consolidado.



\### Conclusión



El ingreso promedio por cliente ayuda a distinguir entre volumen y valor. Los mercados con mayor ingreso total no siempre son los que tienen clientes más rentables en promedio. Por ello, una estrategia comercial más completa debería considerar simultáneamente tres métricas: número de clientes, ingresos totales e ingreso promedio por cliente.









\###Pregunta 5: Nos interesa determinar qué países generan mayores ingresos

Ayuda a decidir qué géneros mantener con mayor disponibilidad en inventario y cuáles pueden necesitar mayor inversión.

La categoría Sports presenta el mayor número de rentas, seguida muy de cerca por Animation, Action, Sci-Fi y Family. La diferencia entre las categorías principales no es demasiado grande, lo que sugiere una demanda relativamente diversificada entre varios géneros.



Desde una perspectiva comercial, las categorías de mayor demanda deberían mantenerse con suficiente disponibilidad en inventario, especialmente en tiendas donde el volumen de rentas sea alto. Además, géneros como Sports, Animation y Action podrían ser candidatos para promociones, recomendaciones destacadas o análisis más profundo por tienda y país.



Interpretación de negocio



Este análisis permite identificar la popularidad de las categorías desde el comportamiento real de renta, no solo desde el tamaño del catálogo. Una siguiente etapa útil sería comparar estas categorías con los ingresos generados, ya que una categoría muy rentada no necesariamente es la más rentable.



\###Pregunta 6: ¿Cuáles son las categorías que más ingresos generan?

Una categoría puede tener muchas rentas pero no ser la más rentable. Esta consulta permite comparar popularidad contra rentabilidad.



Insight

La categoría Sports no solo fue la más rentada, sino también la que generó mayores ingresos, lo que la posiciona como una categoría clave para el negocio. Sin embargo, al comparar con la pregunta anterior, se observa que Sci-Fi aparece como la segunda categoría con mayores ingresos, aunque no era la segunda más rentada; esto sugiere que puede tener un mayor valor económico por renta o una composición de pagos más favorable.



Por otro lado, Animation mantiene una posición alta tanto en volumen de rentas como en ingresos, lo que indica una combinación fuerte entre popularidad y rentabilidad.



Interpretación de negocio



Este análisis permite distinguir entre demanda y rentabilidad. Una categoría puede ser muy popular en número de rentas, pero no necesariamente ser la que más ingresos genera. Para decisiones de inventario, promociones o adquisición de catálogo, la empresa debería considerar ambas métricas: cantidad de rentas e ingresos totales.



Una siguiente etapa útil sería calcular el ingreso promedio por renta en cada categoría para identificar géneros que, aunque tengan menor volumen, podrían generar mayor valor por transacción.





\###Pregunta 7: ¿Cuáles son las películas más rentadas?

Los títulos con mayor demanda pueden usarse para promociones, recomendaciones o decisiones de inventario.



\### Objetivo de negocio



Identificar los títulos con mayor número de rentas para conocer qué películas presentan mayor demanda dentro del catálogo.



\### Resultado principal



Las películas con mayor número de rentas fueron:



| Película | Total de rentas |

|---|---:|

| Bucket Brotherhood | 34 |

| Rocketeer Mother | 33 |

| Forward Temple | 32 |

| Juggler Hardly | 32 |

| Ridgemont Submarine | 32 |

| Grit Clockwork | 32 |

| Scalawag Duck | 32 |

| Robbers Joon | 31 |

| Network Peak | 31 |

| Timberland Sky | 31 |



\### Insight



Aunque los títulos pertenecen a una base de datos de ejemplo, el análisis permite identificar cuáles son los productos con mayor demanda dentro del catálogo. La película \*Bucket Brotherhood\* lidera el ranking con 34 rentas, seguida muy de cerca por varios títulos con entre 31 y 33 rentas.



La diferencia entre los primeros lugares es reducida, lo que sugiere que la demanda no está concentrada en un único título, sino distribuida entre varias películas populares.



\### Interpretación de negocio



Este tipo de análisis permite a una empresa detectar títulos de alta rotación, priorizar disponibilidad en inventario y diseñar recomendaciones o promociones basadas en demanda real. En un contexto empresarial real, estos resultados podrían apoyar decisiones de adquisición de licencias, reposición de inventario o campañas por popularidad.





\###Pregunta 8: ¿Hay clientes registrados sin rentas?

Estos clientes representarían una oportunidad de reactivación mediante campañas de correo, descuentos o recomendaciones.



\### Resultado principal



La consulta devolvió \*\*0 registros\*\*, lo que indica que no existen clientes registrados sin rentas asociadas.



\### Insight



Todos los clientes registrados en la base han realizado al menos una renta. Esto sugiere que la base no contiene usuarios completamente inactivos o registros sin conversión.



Desde una perspectiva de negocio, esto es positivo porque la empresa no presenta una brecha entre clientes registrados y clientes que efectivamente han usado el servicio. Sin embargo, este resultado no implica que todos los clientes sean igual de activos; el siguiente paso sería analizar frecuencia de renta, monto total pagado o fecha de última renta para identificar clientes con baja actividad o posible riesgo de abandono.







\## Pregunta 9: ¿Existen películas sin actores registrados?



\### Objetivo de negocio



Identificar películas dentro del catálogo que no tienen actores asociados en la base de datos. Esta consulta permite detectar posibles problemas de completitud en la información del catálogo y evaluar la calidad de los datos disponibles.



\### Insight



Se encontraron tres películas dentro del catálogo que no tienen actores registrados en la tabla `film\_actor`.



| Film ID | Película |

|---:|---|

| 803 | Slacker Liaisons |

| 323 | Flight Lies |

| 257 | Drumline Cyclone |





Aunque el número de casos es pequeño, este hallazgo es relevante porque indica registros potencialmente incompletos dentro del modelo de datos.



Desde una perspectiva de negocio, la falta de actores asociados puede afectar funcionalidades como búsquedas por elenco, recomendaciones personalizadas, filtros de catálogo o análisis de desempeño por actor. En una base de datos real, estos registros deberían revisarse para determinar si se trata de información faltante, errores de carga o películas que efectivamente no cuentan con elenco registrado.



\### Interpretación de negocio



Este resultado muestra que los `LEFT JOIN` no solo sirven para combinar tablas, sino también para auditar la calidad de los datos. Identificar registros sin correspondencia en tablas relacionadas es una práctica útil para mantener catálogos consistentes, mejorar la experiencia del usuario y evitar que ciertos productos queden menos visibles por información incompleta.



\### Técnica utilizada



Se utilizó un `LEFT JOIN` entre `film` y `film\_actor` para conservar todas las películas del catálogo, incluyendo aquellas que no tenían coincidencias en la tabla de actores. Posteriormente, se filtraron los registros donde `fa.actor\_id IS NULL`, lo que permitió identificar películas sin actores asociados.







\## Pregunta 10: ¿Cada tienda cuenta con inventario en todas las categorías?



\### Objetivo de negocio



Construir una matriz completa entre tiendas y categorías para evaluar la cobertura del inventario. El objetivo es identificar si cada tienda cuenta con películas disponibles en todos los géneros del catálogo y detectar posibles diferencias en la distribución del inventario entre sucursales.



\### Resultado principal



La consulta generó \*\*32 combinaciones tienda-categoría\*\*, correspondientes a las 2 tiendas y las 16 categorías disponibles en la base de datos.



Todas las combinaciones presentaron inventario registrado, lo que indica que ambas tiendas cuentan con al menos una película disponible en cada categoría.



Algunos resultados destacados fueron:



| Tienda | Categoría | Inventario total |

|---:|---|---:|

| 1 | Action | 169 |

| 1 | Animation | 161 |

| 1 | Sports | 163 |

| 1 | Horror | 112 |

| 2 | Sports | 181 |

| 2 | Animation | 174 |

| 2 | Documentary | 164 |

| 2 | Music | 110 |



\### Insight



El análisis muestra que ambas tiendas tienen cobertura completa de categorías, ya que no se encontraron combinaciones tienda-categoría con inventario igual a cero. Esto sugiere que la empresa mantiene una oferta diversificada en sus dos sucursales, evitando que alguna tienda carezca totalmente de un género específico.



Sin embargo, aunque la cobertura es completa, la distribución del inventario no es uniforme. En la tienda 1, categorías como \*\*Action\*\*, \*\*Sports\*\* y \*\*Drama\*\* tienen una presencia alta, mientras que \*\*Horror\*\* y \*\*Travel\*\* presentan menor inventario. En la tienda 2, \*\*Sports\*\*, \*\*Animation\*\*, \*\*Documentary\*\* y \*\*Sci-Fi\*\* destacan por su mayor disponibilidad, mientras que \*\*Music\*\* tiene el inventario más bajo.



\### Interpretación de negocio



Esta consulta permite diferenciar entre \*\*cobertura\*\* y \*\*cantidad de inventario\*\*. La cobertura indica si una tienda cuenta o no con películas de una categoría; la cantidad de inventario permite evaluar qué tan fuerte es la presencia de cada género en cada sucursal.



Desde una perspectiva operativa, este análisis puede ayudar a revisar si la distribución del inventario está alineada con la demanda real por tienda. Por ejemplo, si una categoría tiene alta demanda pero bajo inventario en una sucursal, podría ser necesario redistribuir copias o reforzar la disponibilidad de ese género.



\### Técnica utilizada



Se utilizó un `CROSS JOIN` para generar todas las combinaciones posibles entre tiendas y categorías. Después, mediante `LEFT JOIN`, se comparó esta matriz esperada contra el inventario real disponible. Esta técnica permite detectar posibles huecos de cobertura y evaluar la distribución del inventario de forma estructurada.









\## Pregunta 11: ¿Existen categorías del catálogo sin rentas?



\### Objetivo de negocio



Identificar si existen categorías registradas en el catálogo que no hayan tenido ninguna renta asociada. Esta consulta permite detectar géneros completamente inactivos dentro de la operación.



\### Resultado principal



La consulta no devolvió registros, lo que indica que \*\*todas las categorías del catálogo tuvieron al menos una renta asociada\*\*.



\### Insight



No se encontraron categorías completamente inactivas dentro del catálogo. Esto sugiere que todos los géneros disponibles tuvieron participación en el comportamiento de renta de los clientes.



Desde una perspectiva de negocio, este resultado es positivo porque indica que no existen categorías totalmente desconectadas de la demanda. Sin embargo, esto no significa que todas las categorías tengan el mismo nivel de desempeño; algunas pueden tener muchas más rentas o generar mayores ingresos que otras.



\### Interpretación de negocio



El uso de `EXCEPT` permitió comparar el conjunto completo de categorías registradas contra el conjunto de categorías que sí aparecen en rentas. Al obtener un resultado vacío, se confirma que no hay categorías sin actividad.



Este análisis complementa las consultas de categorías más rentadas y categorías con mayores ingresos: primero confirma que todas las categorías tienen demanda, y después permite evaluar cuáles destacan por volumen o rentabilidad.









\## Pregunta 12: ¿Qué películas del catálogo nunca han sido rentadas?



\### Objetivo de negocio



Identificar películas registradas en el catálogo que no tienen ninguna renta asociada, con el fin de detectar títulos sin rotación dentro de la operación. Este análisis permite encontrar películas que podrían requerir mayor visibilidad, promoción o revisión dentro del catálogo.



\### Resultado principal



La consulta identificó \*\*42 películas registradas en el catálogo sin rentas asociadas\*\*.



Algunos ejemplos fueron:



| Film ID | Película |

|---:|---|

| 955 | Walls Artist |

| 87 | Boondock Ballroom |

| 801 | Sister Freddy |

| 41 | Arsenic Independence |

| 497 | Kill Brotherhood |

| 701 | Psycho Shrunk |

| 195 | Crowds Telemark |

| 318 | Firehouse Vietnam |

| 38 | Ark Ridgemont |



\### Insight 



Se encontraron \*\*42 películas del catálogo sin rentas asociadas\*\*, lo que indica que estos títulos no aparecen conectados a ninguna transacción de renta dentro de la base analizada.



Desde una perspectiva de negocio, este hallazgo puede señalar películas con baja demanda, baja visibilidad dentro del catálogo o registros que requieren revisión. Estos títulos podrían ser candidatos para campañas promocionales, recomendaciones destacadas, ajustes de disponibilidad o análisis más detallado de su presencia en inventario.



\### Interpretación de negocio



Este análisis permite detectar títulos sin rotación, una señal importante para la administración del catálogo. En una empresa de renta de películas, mantener productos que no generan actividad puede representar inventario desaprovechado o una oportunidad para mejorar la estrategia comercial.



Sin embargo, el resultado debe interpretarse con cuidado: la consulta parte de todas las películas registradas en `film`, por lo que una película sin rentas puede deberse a baja demanda, pero también a que no tenga copias disponibles en inventario. Por ello, un siguiente paso útil sería verificar si estas películas cuentan con unidades registradas en la tabla `inventory`.



\### Técnica utilizada



Se utilizó `EXCEPT` para comparar dos conjuntos:



\- El conjunto de todas las películas registradas en la tabla `film`.

\- El conjunto de películas que sí aparecen asociadas a una renta mediante `inventory` y `rental`.



El resultado de esta diferencia devuelve las películas que existen en el catálogo, pero que no tienen rentas asociadas. Esta técnica es útil para detectar ausencias, registros sin actividad o elementos que no cumplen una condición determinada.











\## Pregunta 13: ¿Existen películas con inventario que nunca hayan sido rentadas?



\### Objetivo de negocio



Verificar si las películas identificadas previamente como títulos sin renta cuentan con copias disponibles en inventario. Esta consulta permite distinguir entre películas sin demanda y películas que simplemente no tienen unidades disponibles para renta.



\### Resultado principal



La consulta devolvió \*\*0 registros\*\*.



Esto indica que no existen películas con copias registradas en inventario que no hayan sido rentadas.



\### Insight



El resultado cambia la interpretación de la pregunta anterior. Aunque se identificaron 42 películas del catálogo sin rentas asociadas, al restringir el análisis únicamente a películas con copias disponibles en inventario, no se encontró ningún título sin rotación.



Esto sugiere que las películas sin renta detectadas previamente probablemente no estaban disponibles en inventario, por lo que su falta de rentas no necesariamente refleja baja demanda. En otras palabras, no se puede concluir que esos títulos fueran rechazados por los clientes si no existían copias disponibles para ser rentadas.



\### Interpretación de negocio



Este análisis muestra la importancia de validar el contexto operativo antes de interpretar un resultado. Una película sin rentas puede parecer un producto con baja demanda, pero si no tiene copias en inventario, el problema no es necesariamente comercial, sino de disponibilidad.



Desde una perspectiva de negocio, la empresa no presenta inventario inmovilizado en películas sin rotación: todas las películas con unidades registradas han tenido al menos una renta. Esto sugiere una buena utilización del inventario disponible.



\### Técnica utilizada



Se utilizó `EXCEPT` para comparar dos conjuntos:



\- Películas que tienen copias registradas en `inventory`.

\- Películas que tienen copias en `inventory` y además aparecen asociadas a una renta en `rental`.



Al restar el segundo conjunto del primero, se buscaban películas disponibles que nunca hubieran sido rentadas. El resultado vacío confirma que no existen títulos en inventario sin actividad de renta.







\## Pregunta 14: ¿Qué categorías son fuertes tanto en demanda como en rentabilidad?



\### Objetivo de negocio



Identificar categorías que aparecen simultáneamente dentro del top de categorías más rentadas y dentro del top de categorías con mayores ingresos. El objetivo es detectar géneros estratégicos para el negocio, es decir, categorías que combinan alta demanda con alta contribución económica.



\### Resultado principal



La consulta identificó \*\*8 categorías\*\* que aparecen tanto en el top 10 de categorías más rentadas como en el top 10 de categorías con mayores ingresos:



| Category ID | Categoría |

|---:|---|

| 1 | Action |

| 2 | Animation |

| 7 | Drama |

| 8 | Family |

| 9 | Foreign |

| 10 | Games |

| 14 | Sci-Fi |

| 15 | Sports |



\### Insight



Estas categorías destacan porque combinan dos dimensiones clave: \*\*alta demanda\*\* y \*\*alta rentabilidad\*\*. No solo son géneros frecuentemente rentados por los clientes, sino que también se encuentran entre los que generan mayores ingresos para la empresa.



Categorías como \*\*Sports\*\*, \*\*Animation\*\*, \*\*Action\*\*, \*\*Sci-Fi\*\* y \*\*Drama\*\* ya habían aparecido en análisis anteriores de rentas e ingresos. El uso de `INTERSECT` confirma que estas categorías no son relevantes solo por una métrica aislada, sino que mantienen un buen desempeño en ambos criterios.



\### Interpretación de negocio



Desde una perspectiva comercial, estas categorías pueden considerarse géneros estratégicos. La empresa podría priorizarlas en decisiones de inventario, promociones, recomendaciones y adquisición de catálogo, ya que muestran fortaleza tanto en volumen de renta como en generación de ingresos.



También es útil observar que no todas las categorías del top por rentas coinciden con las del top por ingresos. Esto refuerza la importancia de analizar demanda y rentabilidad de forma conjunta, en lugar de tomar decisiones únicamente con base en una sola métrica.



\### Técnica utilizada



Se utilizó `INTERSECT` para comparar dos conjuntos de resultados:



\- Las 10 categorías con mayor número de rentas.

\- Las 10 categorías con mayores ingresos totales.



El resultado devuelve únicamente las categorías que aparecen en ambos conjuntos. Esta técnica permite identificar coincidencias entre criterios analíticos distintos y es útil para encontrar segmentos o productos que cumplen varias condiciones relevantes al mismo tiempo.









