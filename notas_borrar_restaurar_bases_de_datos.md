# Database Setup: carga, eliminación y restauración de DVD Rental

## Objetivo

Esta sección documenta el proceso completo para cargar, eliminar y volver a restaurar la base de datos **DVD Rental** en PostgreSQL usando pgAdmin.

El objetivo fue practicar el flujo completo desde cero:

1. Guardar los archivos del proyecto.
2. Borrar la base de datos `dvdrental`.
3. Extraer el archivo `dvdrental.zip`.
4. Obtener el archivo `dvdrental.tar`.
5. Crear nuevamente la base vacía.
6. Restaurar la base en pgAdmin.
7. Verificar que las tablas se cargaron correctamente.

---

## 0. Antes de borrar: guardar los archivos del proyecto

Antes de eliminar la base de datos en pgAdmin, se verificó que los archivos del proyecto estuvieran guardados localmente en la carpeta:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\proyecto_joins_dvdrental
```

Dentro de esta carpeta se guardaron los archivos principales del proyecto:

```text
README.md
queries.sql
data_notes.md
setup_database.md
images/
results/
```

Estos archivos son independientes de la base de datos en PostgreSQL. Por lo tanto, borrar la base `dvdrental` desde pgAdmin no elimina los archivos del proyecto almacenados en la computadora.

---

## 1. Archivo original descargado

El archivo descargado originalmente fue:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.zip
```

Este archivo `.zip` no se puede restaurar directamente en pgAdmin. Primero debe extraerse para obtener el archivo `.tar`.

El archivo correcto para restaurar en pgAdmin es:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

---

## 2. Borrar el archivo `.tar` para practicar desde el `.zip`

Para practicar el proceso desde cero, se puede borrar el archivo:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

Pero **no se debe borrar** el archivo original:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.zip
```

El archivo `.zip` es el respaldo comprimido original desde el cual se vuelve a generar el `.tar`.

---

## 3. Borrar la base `dvdrental` en pgAdmin

Para eliminar una base de datos completa, el Query Tool debe abrirse desde la base `postgres`, no desde la base que se quiere borrar.

En pgAdmin:

```text
postgres → Query Tool
```

Primero se cierran conexiones activas hacia `dvdrental`:

```sql
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'dvdrental';
```

Después se elimina la base:

```sql
DROP DATABASE IF EXISTS dvdrental;
```

Si pgAdmin muestra un error relacionado con transacciones, se deben ejecutar ambos comandos por separado:

1. Primero `SELECT pg_terminate_backend(...)`.
2. Después `DROP DATABASE IF EXISTS dvdrental;`.

Después de borrar la base:

```text
Databases → Refresh
```

La base `dvdrental` ya no debería aparecer en el panel izquierdo.

---

## 4. Extraer el archivo ZIP desde CMD

Para obtener el archivo `.tar`, se utilizó CMD / Símbolo del sistema.

Primero se navega a la carpeta donde está el archivo `dvdrental.zip`:

```bash
cd C:\Users\HP\Documents\PORTAFOLIO_sql
```

Luego se extrae el `.zip`:

```bash
tar -xf dvdrental.zip
```

Este comando genera el archivo:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

Para verificar que el archivo fue creado correctamente, se puede ejecutar:

```bash
dir /s /b *dvdrental*
```

El resultado esperado debe incluir:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.zip
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

También se puede verificar con:

```bash
dir
```

y revisar que aparezcan ambos archivos:

```text
dvdrental.zip
dvdrental.tar
```

---

## 5. Crear nuevamente la base vacía

Después de borrar la base y extraer el archivo `.tar`, se crea una nueva base vacía desde el Query Tool de `postgres`:

```sql
CREATE DATABASE dvdrental;
```

Después:

```text
Databases → Refresh
```

Debe aparecer nuevamente la base:

```text
dvdrental
```

---

## 6. Restaurar la base desde pgAdmin

Una vez creada la base vacía, se restaura el archivo `.tar`.

En pgAdmin:

```text
dvdrental → clic derecho → Restore...
```

En la ventana de restauración:

```text
Format: Custom or tar
```

o, si aparece como opción específica:

```text
Format: Tar
```

Después, en `Filename`, se debe seleccionar el archivo:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

Finalmente se da clic en:

```text
Restore
```

El resultado esperado es:

```text
Process completed
```

---

## 7. Problema común: el archivo `.tar` no aparece en la ventana de pgAdmin

Un problema importante fue que, aunque el archivo `dvdrental.tar` ya existía, pgAdmin no lo mostraba en la ventana para seleccionarlo.

La causa fue que la ventana de selección de archivo estaba filtrando únicamente archivos tipo `.backup`.

En la parte inferior de la ventana aparecía algo como:

```text
BACKUP File .backup
```

Por eso el archivo `dvdrental.tar` no aparecía.

### Solución

En la ventana de selección de archivo:

1. Ir a la parte inferior donde dice:

```text
BACKUP File .backup
```

2. Abrir el desplegable.
3. Cambiarlo a:

```text
All files (*)
```

o:

```text
Todos los archivos (*.*)
```

4. Después de cambiar el filtro, el archivo `dvdrental.tar` debe aparecer.
5. Seleccionar:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

6. Dar clic en `Open` / `Abrir`.
7. Ejecutar `Restore`.

Este detalle fue importante porque el problema no era la base de datos ni el archivo `.tar`, sino que Windows/pgAdmin estaba ocultando el archivo debido al filtro de tipo de archivo.

---

## 8. Alternativa: pegar la ruta manualmente

Si el archivo `.tar` sigue sin aparecer, también se puede pegar manualmente la ruta completa en el campo `Filename`:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

Después se selecciona `Open` / `Abrir` y se ejecuta `Restore`.

---

## 9. Verificar que la base fue restaurada correctamente

Después de que pgAdmin muestra:

```text
Process completed
```

se debe verificar que las tablas existan.

Abrir Query Tool desde la base `dvdrental`:

```text
dvdrental → Query Tool
```

No desde `postgres`.

Ejecutar:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

El resultado esperado debe incluir las 15 tablas principales:

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

También se puede hacer una consulta de prueba:

```sql
SELECT *
FROM customer
LIMIT 10;
```

Si devuelve registros, la base fue restaurada correctamente.

---

## 10. Flujo completo para practicar desde cero

El proceso completo para borrar y volver a cargar la base es:

```text
1. Guardar README.md, queries.sql, data_notes.md y setup_database.md.
2. Confirmar que existe dvdrental.zip.
3. Borrar dvdrental.tar si se quiere practicar desde el ZIP.
4. Abrir Query Tool desde postgres.
5. Cerrar conexiones a dvdrental.
6. Borrar la base dvdrental.
7. Extraer dvdrental.zip desde CMD con tar -xf dvdrental.zip.
8. Confirmar que apareció dvdrental.tar.
9. Crear una base vacía llamada dvdrental.
10. Abrir Restore sobre dvdrental.
11. Elegir Format: Custom or tar / Tar.
12. En la ventana de archivo, cambiar el filtro de .backup a All files si el .tar no aparece.
13. Seleccionar C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar.
14. Ejecutar Restore.
15. Confirmar Process completed.
16. Verificar las tablas desde Query Tool de dvdrental.
17. Ejecutar SELECT * FROM customer LIMIT 10.
```

---

## 11. Resumen del problema principal

El problema principal fue intentar restaurar la base sin tener claro el formato correcto del archivo.

El flujo correcto fue:

```text
dvdrental.zip → extraer → dvdrental.tar → Restore en pgAdmin con Format: Tar
```

Y la ruta final utilizada para restaurar la base fue:

```text
C:\Users\HP\Documents\PORTAFOLIO_sql\dvdrental.tar
```

---

## 12. Diferencia entre formatos

Durante el proceso fue importante distinguir entre varios tipos de archivo:

| Formato | Qué es | Cómo se carga |
|---|---|---|
| `.csv` | Archivo plano con una sola tabla | Importación o carga con Python |
| `.zip` | Archivo comprimido | Primero debe extraerse |
| `.tar` | Respaldo de PostgreSQL | Restore en pgAdmin con formato `Custom or tar` / `Tar` |
| `.backup` | Respaldo de PostgreSQL | Restore en pgAdmin con formato `Custom or tar` |
| Carpeta con `toc.dat` | Respaldo tipo Directory | Restore en pgAdmin con formato `Directory` |

En este proyecto, el archivo correcto fue:

```text
dvdrental.tar
```

---

## 13. Conclusión

Restaurar una base de datos completa no es lo mismo que cargar un CSV.

En un proyecto anterior con Airbnb se cargó una sola tabla desde un archivo `.csv`. En cambio, DVD Rental es una base relacional completa, con múltiples tablas, llaves y relaciones. Por eso se restauró desde un respaldo `.tar` usando pgAdmin.

Este proceso permitió practicar tareas importantes para trabajar con bases de datos:

- eliminar una base local;
- crear una base vacía;
- extraer un archivo comprimido;
- identificar el formato correcto de respaldo;
- restaurar una base desde pgAdmin;
- resolver problemas de selección de archivos;
- verificar tablas cargadas;
- ejecutar consultas de validación.

Una vez restaurada, la base quedó lista para realizar consultas SQL con múltiples tablas, `JOIN`, agregaciones, operaciones de conjuntos y análisis de negocio.