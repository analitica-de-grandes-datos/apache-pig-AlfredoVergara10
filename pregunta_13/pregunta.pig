/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta en SQL.

   SELECT
       color
   FROM 
       u 
   WHERE 
       color 
   LIKE 'b%';

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


-- Obtener los valores de la columna color.
words = FOREACH u GENERATE color;

-- Filtrar los valores por aquellos que empiezan por la letra "b".
values = FILTER words BY $0 MATCHES 'b.*';

-- Escribir el archivo de salida.
STORE values INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .