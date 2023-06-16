/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

-- Obtener sólo las claves de los valores de la columna 3.
keys = FOREACH data GENERATE KEYSET(col3);

-- Obtener todos los valores de las claves de la columna 3.
flatted = FOREACH keys GENERATE FLATTEN($0);

-- Agrupar por los valores obtenidos.
groups = GROUP flatted BY $0;

-- Contar la cantidad de valores por grupo.
values = FOREACH groups GENERATE $0, COUNT($1);

-- Escribir el archivo de salida delimitado por comas.
STORE values INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
