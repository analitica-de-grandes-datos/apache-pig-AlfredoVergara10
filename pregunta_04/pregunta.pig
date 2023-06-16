/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/

-- Obtén los primeros 10 registros para las primeras tres columnas
result = FOREACH (LIMIT data 10) GENERATE driverId, truckId, eventTime;

-- Ordena los resultados por driverId, truckId y eventTime
sorted_result = ORDER result BY driverId, truckId, eventTime;

-- Almacena los resultados en formato CSV
STORE sorted_result INTO 'output' USING PigStorage(',');

-- Muestra los resultados en la consola
DUMP sorted_result;
