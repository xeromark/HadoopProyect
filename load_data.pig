-- Cargar el archivo de datos desde HDFS
data = LOAD '/home/input/Datasets' 
    USING PigStorage(',') 
    AS (branch_addr: chararray, branch_type: chararray, taken: int, target: chararray);



-- También se puede almacenar los datos procesados en otro archivo en HDFS
-- STORE data INTO '/user/hadoop/output/processed_data' USING PigStorage(',');

-- Mostrar datos:
---- DUMP data;

-- limitar a solo mostrar las primeras 10 lineas
---- limited_data = LIMIT data 10;

-- Mostrar el conteno de lineas
---- grouped_data = GROUP data ALL;
---- line_count = FOREACH grouped_data GENERATE COUNT(data);
---- DUMP line_count;