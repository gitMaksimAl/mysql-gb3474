USE lesson_5;

# Создайте представление, в которое попадут автомобили
# стоимостью до 25 000 долларов
CREATE OR REPLACE VIEW affordable_price AS
    SELECT * FROM cars WHERE cost < 25000;

# Изменить в существующем представлении порог для стоимости: пусть цена будет
# до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW affordable_price AS
    SELECT * FROM cars WHERE cost < 30000;

# Создайте представление, в котором будут только автомобили марки
# “Шкода” и “Ауди”
CREATE OR REPLACE VIEW favorite_brand AS
    SELECT * FROM cars WHERE name IN ('Skoda', 'Audi');