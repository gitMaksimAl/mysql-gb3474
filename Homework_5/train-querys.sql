USE lesson_5;

CREATE TABLE IF NOT EXISTS train_schedule
    (train_id INT,
    station VARCHAR(25),
    station_time TIME);

LOAD DATA INFILE 'MOCK_DATA.csv'
INTO TABLE train_schedule
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

# Добавьте новый столбец под названием «время до следующей станции»
CREATE OR REPLACE VIEW extend_shedule AS
SELECT
    train_id,
    station,
    station_time,
    TIMEDIFF(LEAD(station_time) OVER w, station_time) AS time_to_next_station
FROM train_schedule
WINDOW  w AS (PARTITION BY train_id ORDER BY station_time);

SELECT * FROM extend_shedule;