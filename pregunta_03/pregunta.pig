/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo de datos.
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (col1:CHARARRAY,
        col2:DATETIME,
        col3:INT);

-- Ordenar los registros por los valores en la columna 3.
ordered = ORDER data BY col3;

-- Obtener sólo los valores de la columna 3.
values = FOREACH ordered GENERATE col3;

-- Obtener sólo los primeros 5 valores.
limited = LIMIT values 5;

-- Escribir el archivo de salida.
STORE limited INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
