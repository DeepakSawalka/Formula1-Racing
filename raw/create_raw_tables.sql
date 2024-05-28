-- Databricks notebook source

CREATE DATABASE IF NOT EXISTS f1_raw;

-- COMMAND ----------

-- MAGIC
-- MAGIC %md
-- MAGIC #### Create tables for CSV files
-- MAGIC #### 1. circuit table
-- MAGIC #### 2. races table

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.circuits;
CREATE TABLE IF NOT EXISTS f1_raw.circuits(circuitId INT,
circuitRef STRING,
name STRING,
location STRING,
country STRING,
lat DOUBLE,
lng DOUBLE,
alt INT,
url STRING
)
USING csv
OPTIONS (path "/mnt/formulaf1dlsa/bronze/circuits.csv", header true)
)

-- COMMAND ----------


SELECT * FROM f1_raw.circuits;

-- COMMAND ----------

-- MAGIC
-- MAGIC %md
-- MAGIC #### Create races table

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.races;
CREATE TABLE IF NOT EXISTS f1_raw.races(raceId INT,
year INT,
round INT,
circuitId INT,
name STRING,
date DATE,
time STRING,
url STRING)
USING csv
OPTIONS (path "/mnt/formulaf1dlsa/bronze/races.csv", header true)

-- COMMAND ----------


SELECT * FROM f1_raw.races;

-- COMMAND ----------

-- MAGIC
-- MAGIC %md
-- MAGIC #### Create tables for JSON files
-- MAGIC #### 1. constructors tables (Single line JSON and simple structure)
-- MAGIC #### 2. drivers tables (Single line JSON and complex structure)
-- MAGIC #### 3. results tables (Single line JSON and simple structure)
-- MAGIC #### 4. pit_stops tables (multiLine line JSON and simple structure)
-- MAGIC #### 5. lap_times tables (multiple files, Single line JSON and simple structure)
-- MAGIC #### 6. qualifying tables (multiple files, multiLine line JSON and simple structure)
-- MAGIC
-- MAGIC

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.constructors;
CREATE TABLE IF NOT EXISTS f1_raw.constructors(
constructorId INT,
constructorRef STRING,
name STRING,
nationality STRING,
url STRING)
USING json
OPTIONS(path "/mnt/formulaf1dlsa/bronze/constructors.json")

-- COMMAND ----------

SELECT * FROM f1_raw.constructors;

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.drivers;
CREATE TABLE IF NOT EXISTS f1_raw.drivers(
driverId INT,
driverRef STRING,
number INT,
code STRING,
name STRUCT<forename: STRING, surname: STRING>,
dob DATE,
nationality STRING,
url STRING)
USING json
OPTIONS (path "/mnt/formulaf1dlsa/bronze/drivers.json")

-- COMMAND ----------


SELECT * FROM f1_raw.drivers;

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.results;
CREATE TABLE IF NOT EXISTS f1_raw.results(
resultId INT,
raceId INT,
driverId INT,
constructorId INT,
number INT,grid INT,
position INT,
positionText STRING,
positionOrder INT,
points INT,
laps INT,
time STRING,
milliseconds INT,
fastestLap INT,
rank INT,
fastestLapTime STRING,
fastestLapSpeed FLOAT,
statusId STRING)
USING json
OPTIONS(path "/mnt/formulaf1dlsa/bronze/results.json")

-- COMMAND ----------


SELECT * FROM f1_raw.results;

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.pit_stops;
CREATE TABLE IF NOT EXISTS f1_raw.pit_stops(
driverId INT,
duration STRING,
lap INT,
milliseconds INT,
raceId INT,
stop INT,
time STRING)
USING json
OPTIONS(path "/mnt/formulaf1dlsa/bronze/pit_stops.json", multiLine true)

-- COMMAND ----------


SELECT * FROM f1_raw.pit_stops;

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.lap_times;
CREATE TABLE IF NOT EXISTS f1_raw.lap_times(
raceId INT,
driverId INT,
lap INT,
position INT,
time STRING,
milliseconds INT
)
USING csv
OPTIONS (path "/mnt/formulaf1dlsa/bronze/lap_times")

-- COMMAND ----------


SELECT * FROM f1_raw.lap_times;

-- COMMAND ----------


DROP TABLE IF EXISTS f1_raw.qualifying;
CREATE TABLE IF NOT EXISTS f1_raw.qualifying(
constructorId INT,
driverId INT,
number INT,
position INT,
q1 STRING,
q2 STRING,
q3 STRING,
qualifyId INT,
raceId INT)
USING json
OPTIONS (path "/mnt/formulaf1dlsa/bronze/qualifying", multiLine true)

-- COMMAND ----------


SELECT * FROM f1_raw.qualifying

-- COMMAND ----------


DESC EXTENDED f1_raw.qualifying;

-- COMMAND ----------



-- COMMAND ----------
