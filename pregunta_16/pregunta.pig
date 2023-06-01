/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT
       firstname,
       color
   FROM 
       u
   WHERE color = 'blue' OR firstname LIKE 'K%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */
*/

u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);


-- Obtener los valores de la columna firstname y la columna color.
words = FOREACH u GENERATE firstname, color;

-- Filtrar los valores por aquellos donde firstname empieza por la letra "K" o color coincide con "blue".
values = FILTER words BY $0 MATCHES 'K.*' OR $1 MATCHES 'blue';

-- Escribir el archivo de salida delimitado por comas.
STORE values INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .