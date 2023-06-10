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
   WHERE 
       color REGEXP 'blue|green';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

-- Obtener los valores de la columna firstname y la columna color.
words = FOREACH u GENERATE firstname, color;

-- Filtrar los valores por aquellos donde color coincide con la expresión regular "blue|green".
values = FILTER words BY $1 MATCHES '(blue|green).*';

-- Escribir el archivo de salida.
STORE values INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .