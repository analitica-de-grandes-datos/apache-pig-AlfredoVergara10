/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);


-- Obtener los años de la columna birthday.
dates = FOREACH u GENERATE ToString(ToDate(birthday, 'y-M-d'), 'Y');

-- Agrupar los registros por año.
groups = GROUP dates BY $0;

-- Contar la cantidad de registros por año.
counts = FOREACH groups GENERATE $0, COUNT($1);

-- Escribir el archivo de salida delimitado por comas.
STORE counts INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .