# HadoopProyect

La imagen proviene del siguiente link
https://hub.docker.com/r/suhothayan/hadoop-spark-pig-hive


# Pasos previos, Dar nombre del contenedor: "analiz" por analizador

docker run -it --name analiz -p 50070:50070 -p 8088:8088 -p 8080:8080 suhothayan/hadoop-spark-pig-hive:2.9.2 bash



# 1) Pasar archivo de ubuntu al contenedor
    docker cp ./Datasets.gz analiz:/home
 
# 2) Crear una carpeta adentro de home con mkdir con nombre input

# 3) Descomprimir archivo
    gunzip Datasets.gz

# 4) Subir a hdfs 

    docker exec analiz hdfs dfs -copyFromLocal -f /home/input /input


# 5) Saber si ya se copio el dataset

    docker exec analiz hdfs dfs -ls /input

   # Ver la primera linea del csv: hdfs dfs -cat /input/input | head

# 6) Ahora se deben crear las tablas en hive

    Recordar que la tabla se estructurara asi:

    branch_addr,branch_type,taken,target
    0x2181d358,conditional_jump,0,0x2181fca7
    0x2181d36c,conditional_jump,0,0x2181d390
    0x2181d372,conditional_jump,0,0x270c3778

# para abrir la terminal en hive escribimos: hive

---------> entonces tenemos:

    CREATE TABLE datos (
        branch_addr STRING,
        branch_type STRING,
        taken INT,
        target STRING
    )
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE;

..................................
Considerar: 
SELECT * FROM branches;
SHOW TABLES;

# 7) Subir el archivo de hdfs a hive



LOAD DATA INPATH '/input/Datasets' INTO TABLE datos;

# <==============================================================================================================================>
# <==============================================================================================================================>


# Preguntas INFORME

# 1. Obtener el numero de registros

SELECT COUNT(*) FROM datos;

# 2. Contar la frecuencia de cada tipo de branch utilizando Pig y Hive.

SELECT COUNT(branch_type), branch_type FROM datos GROUP BY branch_type;

# 3. Analizar la relacion entre los tipos de branch y el valor de ”taken” (1 o 0) utilizando Pig y Hive

SELECT COUNT(branch_type), branch_type, taken FROM datos GROUP BY branch_type, taken;


# 4. Calcular la proporcion de registros con ”taken” igual a 1 para cada tipo de branch.

SELECT COUNT(branch_type), branch_type, taken FROM datos WHERE taken = 1 GROUP BY branch_type, taken;


# 5. Crear tablas en Hive para almacenar los resultados de los analisis realizados.
# 6. Almacenar los conteos de frecuencia y las relaciones analizadas en tablas separadas en Hive.
# 7. Realizar los analisis anteriores para distintas tramas de datos de forma aleatoria, para ello se solicita tomar muestras de potencia de 10, hasta llegar a un punto en que la query tarde un tiempo maximo o cercano a 1h




hdfs dfs -ls /home/input/Datasets
pig load_data.pig



docker exec namenode hadoop jar /tmp/WordCount.jar WordCount /input/wikipedia/Mochila1.txt /output/Salidal

hdfs dfs -rm -r /input
hdfs dfs -ls /input

head -n 3 Datasets

SELECT * FROM datos limit 1;
