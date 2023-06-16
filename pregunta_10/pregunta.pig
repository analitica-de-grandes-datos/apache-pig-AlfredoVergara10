/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

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


-- Obtener los valores de la columna surname.
words = FOREACH u generate surname;

-- Obtener los valores de la columna surname y su número de letras.
values = FOREACH words generate $0, SIZE($0);

-- Ordenar los valores por número de letras de mayor a menor.
ordered = ORDER values BY $1 DESC, $0;

-- Limitar el archivo de salida a los primeros 5 registros.
limited = LIMIT ordered 5;

-- Escribir el archivo de salida delimitado por un comas.
STORE limited INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
