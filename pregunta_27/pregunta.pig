/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname, 
       LOCATE('ia', firstname) 
   FROM 
       u;

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


-- Obtener el índice de la primera coincidencia de "ia" en los valores de la columna firstname.
values = FOREACH u GENERATE INDEXOF(firstname, 'ia', 0);

-- Escribir el archivo de salida.
STORE values INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .