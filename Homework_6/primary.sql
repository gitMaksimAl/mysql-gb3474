USE vk_db;
# Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней,
# часов, минут и секунд.
DROP FUNCTION IF EXISTS get_times;
DELIMITER $$
CREATE FUNCTION get_times
(
dividend INT
)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE minutes INT;
    DECLARE seconds INT;
    DECLARE hours INT;
    SET seconds = dividend MOD 60;
    SET minutes = dividend DIV 60;
    SET hours = minutes DIV 60;
    SET minutes = minutes MOD 60;
    SET days = hours DIV 24;
    SET hours = hours MOD 24;
    RETURN CONCAT(days, ' days ',
        hours, ' hours ',
        minutes, ' minutes ',
        seconds, ' seconds.');
END $$
DELIMITER ;

SELECT get_times(55);

# Выведите только четные числа от 1 до 10 (Через цикл)
DROP PROCEDURE IF EXISTS get_even;
DELIMITER $$
CREATE PROCEDURE get_even()
BEGIN
    DECLARE result VARCHAR(45) DEFAULT "";
    DECLARE n INT DEFAULT 2;
    REPEAT
        SET result = CONCAT(result, n, ', ');
        SET n = n + 2;
    UNTIL  n = 10
    END REPEAT;
    SELECT CONCAT(result, n) AS result;
END $$
DELIMITER ;

CALL get_even();