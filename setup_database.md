# Database Setup



## Base de datos utilizada



Para este proyecto se utilizó la base de datos de ejemplo **DVD Rental**, diseñada para practicar consultas SQL en PostgreSQL.



La base simula la operación de una empresa de renta de películas e incluye tablas relacionadas con clientes, películas, rentas, pagos, inventario, tiendas, empleados, categorías, actores y ubicaciones.



\---


## Herramientas utilizadas

- PostgreSQL

- pgAdmin

- CMD / Símbolo del sistema de Windows

- Archivo de respaldo `dvdrental.tar`

- SQL



\---



## Objetivo de esta sección



Documentar el proceso seguido para descargar, preparar, restaurar y verificar la base de datos **DVD Rental** en PostgreSQL usando pgAdmin.



Esta sección también incluye los problemas encontrados durante la carga, ya que el proceso permitió entender la diferencia entre cargar un archivo `.csv`, restaurar un respaldo `.tar` y restaurar un respaldo tipo `Directory`.



\---



## Proceso de descarga y carga



### 1. Descarga de la base



Se descargó la base de datos DVD Rental como archivo comprimido:



```text

dvdrental.zip

```



El archivo fue guardado localmente en la carpeta:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql

```



Por lo tanto, la ruta inicial del archivo descargado fue:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\dvdrental.zip

```



\---



### 2. Problema inicial: confusión entre ZIP, TAR y carpeta extraída



Inicialmente, al abrir el archivo desde Windows, parecía contener archivos como:



```text

3055.dat

3057.dat

3059.dat

...

restore.sql

toc.dat

```



Esto generó confusión porque parecía que la base debía cargarse como una carpeta usando el formato `Directory` en pgAdmin.



Sin embargo, el archivo descargado originalmente era un `.zip`, y PostgreSQL/pgAdmin no restaura directamente este formato como base de datos. Primero era necesario extraer el archivo correcto para obtener el respaldo en formato `.tar`.



\---



## Intentos fallidos durante la restauración



### 1. Intento usando formato Directory



En pgAdmin se creó primero una base vacía llamada:



```sql

CREATE DATABASE dvdrental;

```



Después se intentó restaurar la base desde:



```text

dvdrental → Restore

```



En la ventana de restauración se seleccionó:



```text

Format: Directory

```



Sin embargo, el proceso falló porque pgAdmin intentó buscar un archivo `toc.dat` en una ruta temporal/corta de Windows, pero no lo encontró.



El error mostrado fue similar a:



```text

pg\_restore: error: could not open input file 

"C:\\Users\\HP\\DOCUME\~1\\DVDREN\~1/toc.dat": No such file or directory



pg\_restore: error: utility failed with exit code: 1

```



Este error indicaba que la ruta seleccionada no correspondía realmente a una carpeta válida de respaldo tipo `Directory`.



\---



### 2. Verificación de si existía un respaldo tipo Directory



Para comprobar si realmente existía un archivo `toc.dat` dentro de la carpeta del proyecto, se intentó buscarlo desde CMD con el comando:



```bash

dir /s /b C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\toc.dat

```



El comando no devolvió resultados, lo que confirmó que no existía una carpeta de respaldo tipo `Directory` lista para restaurar.



Esto permitió descartar la opción `Directory`.



\---



### 3. Identificación del archivo real disponible



Después se buscó qué archivos relacionados con `dvdrental` existían en la carpeta del proyecto usando:



```bash

dir /s /b C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\\*dvdrental\*

```



El resultado mostró que el único archivo disponible en ese momento era:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\dvdrental.zip

```



Esto confirmó que el problema era que todavía no se había extraído correctamente el archivo `.tar` necesario para restaurar la base.



\---



## Solución encontrada



### 1. Extraer el archivo ZIP desde CMD



La solución fue extraer el archivo `.zip` desde CMD usando el comando:



```bash

cd C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql

tar -xf dvdrental.zip

```



Después de ejecutar este comando, se obtuvo el archivo correcto:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\dvdrental.tar

```



Este era el archivo que debía utilizarse en pgAdmin para restaurar la base.



\---



### 2. Restauración correcta en pgAdmin



Una vez obtenido el archivo `dvdrental.tar`, se utilizó pgAdmin para restaurar la base.



Primero se confirmó la existencia de la base vacía:



```sql

CREATE DATABASE dvdrental;

```



Después, en pgAdmin:



1. Se hizo clic derecho sobre la base `dvdrental`.

2. Se seleccionó la opción `Restore`.

3. En `Format`, se seleccionó:



```text

Tar

```



4\. En `Filename`, se seleccionó la ruta completa:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\dvdrental.tar

```



5. Se ejecutó el proceso de restauración.



El proceso terminó correctamente con el mensaje:



```text

Process completed

```



\---



## Verificación final de la carga



Después de restaurar la base, se verificó que las tablas principales estuvieran disponibles en pgAdmin siguiendo la ruta:



```text

dvdrental → Schemas → public → Tables

```



Se cargaron correctamente 15 tablas:



```text

actor

address

category

city

country

customer

film

film_actor

film_category

inventory

language

payment

rental

staff

store

```



También se ejecutó una consulta de prueba:



```sql

SELECT *

FROM customer

LIMIT 10;

```



La consulta devolvió registros correctamente, confirmando que la base estaba lista para el análisis.



\---



## Resumen del problema y solución



El problema principal fue intentar restaurar la base como si fuera un respaldo tipo `Directory`, cuando en realidad el archivo disponible era un `.zip`.



La solución correcta fue:



```text

dvdrental.zip → extraer → dvdrental.tar → Restore en pgAdmin con Format: Tar

```



Ruta final utilizada para restaurar la base:



```text

C:\\Users\\HP\\Documents\\PORTAFOLIO\_sql\\dvdrental.tar

```



\---



## Diferencia entre los formatos encontrados



Durante el proceso fue importante distinguir entre distintos tipos de archivos:



| Formato | Descripción | Método de carga |

|---|---|---|

| `.csv` | Archivo plano con una sola tabla | Importación o carga con Python |

| `.zip` | Archivo comprimido | Primero debe extraerse |

| `.tar` | Respaldo de PostgreSQL | `Restore` en pgAdmin con formato `Tar` |

| Carpeta con `toc.dat` | Respaldo tipo Directory | `Restore` en pgAdmin con formato `Directory` |



En este proyecto, el archivo correcto para restaurar fue:



```text

dvdrental.tar

```



\---



## Archivos del proyecto



El archivo de respaldo original no se incluye en este repositorio para evitar subir archivos pesados. En su lugar, el repositorio documenta el proceso de carga y contiene:



- `README.md`: descripción general del proyecto, preguntas de negocio e insights.

- `queries.sql`: consultas SQL utilizadas en el análisis.

- `data_notes.md`: notas sobre el modelo relacional y las tablas principales.

- `setup_database.md`: documentación del proceso de descarga, carga y restauración de la base.

- `images`: diagrama entidad-relación de la base.

- `results`: resultados exportados de algunas consultas.



\---



## Consulta de validación adicional



Para verificar que las tablas se encontraban disponibles en el esquema `public`, también se puede ejecutar:



```sql

SELECT table_name

FROM information_schema.tables

WHERE table_schema = 'public'

ORDER BY table_name;

```



El resultado esperado incluye las tablas:



```text

actor

address

category

city

country

customer

film

film_actor

film_category

inventory

language

payment

rental

staff

store

```



\---



## Conclusión del proceso de carga



La carga de la base permitió entender que una base relacional completa no se carga igual que un archivo CSV.



En el caso de Airbnb, la carga se realizó desde un archivo `.csv` hacia PostgreSQL mediante Python. En cambio, para DVD Rental se utilizó un respaldo de PostgreSQL en formato `.tar`, restaurado directamente desde pgAdmin.



Este proceso fue importante para distinguir entre:



- cargar una tabla plana;

- restaurar una base de datos completa;

- seleccionar correctamente el formato de respaldo;

- validar que las tablas se hayan cargado correctamente.



Una vez completada la restauración, la base quedó lista para realizar consultas SQL con múltiples tablas, `JOIN`, agregaciones, operaciones de conjuntos y análisis de negocio.

