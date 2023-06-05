/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

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


-- Obtener los años de los valores de la columna birthday y además su conversión a formato DATETIME.
dates = FOREACH u GENERATE ToDate(birthday, 'y-M-d');

-- Obtener los valores de la columna birthday junto con distintas representaciones del mes.
values = FOREACH dates GENERATE ToString($0, 'YYYY-MM-dd'), (
    CASE GetMonth($0)
        WHEN 1 THEN 'ene'
        WHEN 2 THEN 'feb'
        WHEN 3 THEN 'mar'
        WHEN 4 THEN 'abr'
        WHEN 5 THEN 'may'
        WHEN 6 THEN 'jun'
        WHEN 7 THEN 'jul'
        WHEN 8 THEN 'ago'
        WHEN 9 THEN 'sep'
        WHEN 10 THEN 'oct'
        WHEN 11 THEN 'nov'
        WHEN 12 THEN 'dic'
    END
), ToString($0, 'MM'), GetMonth($0);

-- Escribir el archivo de salida delimitado por comas.
STORE values INTO 'output' USING PigStorage (',');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .