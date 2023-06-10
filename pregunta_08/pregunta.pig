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

-- Cargar el archivo de datos.
data = LOAD 'data.tsv' USING PigStorage(',')
    AS (col1:CHARARRAY,
        col2:BAG{t:TUPLE(p:CHARARRAY)},
        col3:MAP[]);

-- Obtener los elementos de los valores en la columna 2 y la columna 3 en forma de tupla.
values = FOREACH data GENERATE FLATTEN(col2), FLATTEN(KEYSET(col3));

-- Agrupar los elementos por tupla generada.
grouped = GROUP values BY ($0,$1);

-- Contar el número de coincidencias.
counts = FOREACH grouped GENERATE $0, COUNT($1);

-- Escribir el archivo de salida.
STORE counts INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
