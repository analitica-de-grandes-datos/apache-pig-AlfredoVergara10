/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Leer Archivo
data = LOAD 'data.tsv' AS (col1: chararray, col2: bag{}, col3: map[]);

-- Generar tabla con la letra de col2 y clave de col3
table0 = FOREACH data GENERATE FLATTEN(col2) AS letra, FLATTEN(col3) AS clave;
table= FOREACH table0 GENERATE $0 AS letter, $1 AS key;

-- Agrupar y contar registros por letra y clave
grouped_table = GROUP table BY (letter, key);
result = FOREACH grouped_table GENERATE $0 as letter, SIZE($1) AS value;

-- Escribir resultado en carpeta "output"
STORE result INTO 'output' USING PigStorage(',');

-- Mostrar resultado
DUMP result;
