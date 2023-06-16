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

-- Carga el archivo TSV
data = LOAD 'data.tsv' USING PigStorage('\t') AS (col1: chararray, col2: chararray, col3: int);

-- Ordena los datos por letra y valor
sorted_data = ORDER data BY col1, col3;

-- Almacena los resultados en formato CSV
STORE sorted_data INTO 'output' USING PigStorage(',');

-- Muestra los resultados en la consola
DUMP sorted_data;
