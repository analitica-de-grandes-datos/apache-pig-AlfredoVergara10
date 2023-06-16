/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo de datos.
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (col1:CHARARRAY,
        col2:BAG{t:TUPLE(p:CHARARRAY)},
        col3:MAP[]);

-- Obtener los valores de la columna 1, el número de elementos de la columna 2 y de la columna 3.
values = FOREACH data GENERATE col1, COUNT(col2), SIZE(col3);

-- Ordenar los registros por los valores en la columna 1, luego la columna 2 y luego la columna 3.
ordered = ORDER values BY $0, $1, $2;

-- Escribir el archivo de salida delimitado por comas.
STORE ordered INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
