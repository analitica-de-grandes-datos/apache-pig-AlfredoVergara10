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


-- Carga el archivo TSV
data = LOAD 'data.tsv' USING PigStorage('\t') AS (col1: chararray, col2: chararray);

-- Agrupa los registros por letra
grouped_data = GROUP data BY SUBSTRING(col1, 0, 1);

-- Calcula la cantidad de registros por letra
count_data = FOREACH grouped_data GENERATE group AS letter, COUNT(data) AS count;

-- Almacena los resultados en formato CSV
STORE count_data INTO 'output' USING PigStorage(',');

-- Muestra los resultados en la consola
DUMP count_data;
