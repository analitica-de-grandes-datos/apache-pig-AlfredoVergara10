/*
Pregunta
===========================================================================

Para el archivo `data.csv` escriba una consulta en Pig que genere la 
siguiente salida:

  Vivian@Hamilton
  Karen@Holcomb
  Cody@Garrett
  Roth@Fry
  Zoe@Conway
  Gretchen@Kinney
  Driscoll@Klein
  Karyn@Diaz
  Merritt@Guy
  Kylan@Sexton
  Jordan@Estes
  Hope@Coffey
  Vivian@Crane
  Clio@Noel
  Hope@Silva
  Ayanna@Jarvis
  Chanda@Boyer
  Chadwick@Knight

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo de datos.
data = LOAD 'data.csv' USING PigStorage(',')
    AS (id:INT,
        firstname:CHARARRAY,
        surname:CHARARRAY,
        birtday:DATETIME,
        color:CHARARRAY,
        quantity:INT);

-- Obtener los valores de la columna firstname y los de la columna surname.
values = FOREACH data GENERATE firstname, surname;

-- Escribir el archivo de salida delimitado por un "@".
STORE values INTO 'output' USING PigStorage ('@');

-- Copiar los archivos del HDFS al sistema local.
fs -get output/ .
