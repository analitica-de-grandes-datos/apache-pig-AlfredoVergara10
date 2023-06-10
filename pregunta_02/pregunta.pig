/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

-- Cargar el archivo de datos.
data = LOAD 'data.tsv' USING PigStorage(',')
    AS (col1:CHARARRAY,
        col2:DATETIME,
        col3:INT);

-- Obtener sólo las fechas de los valores de la columna 2.
dates = FOREACH data GENERATE col1, ToString(col2, 'yyyy-MM-dd') as col2, col3;

-- Ordenar los registros por los valores en la columna 1 y luego por los valores en la columna 3.
ordered = ORDER dates BY col1, col3;

-- Escribir el archivo de salida.
STORE ordered INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
