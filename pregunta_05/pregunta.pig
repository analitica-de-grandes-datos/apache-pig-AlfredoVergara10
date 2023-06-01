/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

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

-- Obtener los valores de los elementos de la columna 2.
flatted = FOREACH data GENERATE FLATTEN(col2);

-- Agrupar los registros por los valores en la columna 2.
groups = GROUP flatted BY $0;

-- Contar la cantidad de registros por cada valor.
values = FOREACH groups GENERATE $0, COUNT($1);

-- Escribir el archivo de salida.
STORE values INTO 'output';

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
