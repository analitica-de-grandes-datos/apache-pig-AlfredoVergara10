/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


-- Cargar el archivo de datos.
data = LOAD 'data.tsv' USING PigStorage(',')
    AS (col1:CHARARRAY,
        col2:DATETIME,
        col3:INT);

-- Agrupar los registros por los valores en la columna 1.
groups = GROUP data BY col1;

-- Contar la cantidad de registros por valor.
counts = FOREACH groups GENERATE $0, COUNT($1);

-- Escribir el archivo de salida.
STORE counts INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
