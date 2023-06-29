USE lesson_3;

# Создать процедуру коорая будет выводить статус сотрудника по зп.
# Номер сотрудоника, статус сотрудника в отдельную переменную.
DROP PROCEDURE IF EXISTS get_status;
DELIMITER $$ -- start of procedure for server
CREATE PROCEDURE get_status
    (
    IN staff_number INT, -- read only param
    OUT staff_status VARCHAR(45) -- can change this value
    ) -- parameters
    BEGIN
        DECLARE staff_salary DOUBLE;
        SELECT salary INTO staff_salary
        FROM staff
        WHERE id = staff_number;

        IF staff_salary BETWEEN 0 AND 49999
            THEN SET staff_status = 'Средняя ЗП';
        ELSEIF staff_salary BETWEEN 50000 AND 69999
            THEN SET staff_status = 'Средняя ЗП';
        ELSEIF staff_salary >= 70000
            THEN SET staff_status = 'Средняя ЗП';
        END IF;-- end of procedure
    END $$
DELIMITER ;

CALL get_status(4, @res_out);
SELECT @res_out;

# Функция для вычисления возраста человека
DROP FUNCTION IF EXISTS get_age;
DELIMITER $$
CREATE FUNCTION get_age
(
birthday DATE,
someday DATETIME
)
RETURNS INT
DETERMINISTIC
RETURN (YEAR(someday) - YEAR(birthday));
DELIMITER ;

# Вызов функции
SELECT get_age('1986-09-25', NOW());


USE vk_db;

# Создание процедуры для добавления нового пользователя с
# использованием транзакций
DROP PROCEDURE IF EXISTS user_add;
DELIMITER $$
CREATE PROCEDURE user_add
(
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(50),
phone VARCHAR(50),
gender CHAR(1),
hometown VARCHAR(50),
photo_id INT,
birthday DATE,
OUT result VARCHAR(300)
)
BEGIN
    DECLARE _rollback BIT DEFAULT 0;
    DECLARE code_err VARCHAR(300);
    DECLARE text_err VARCHAR(300);

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET _rollback = 1;
            GET STACKED DIAGNOSTICS CONDITION 1
            code_err = RETURNED_SQLSTATE, text_err = MESSAGE_TEXT;
        END;

    START TRANSACTION;
    INSERT INTO users(firstname, lastname, email, phone)
        VALUES (firstname, lastname, email, phone);
    INSERT INTO profiles(user_id, gender, birthday, photo_id, created_at, hometown)
        VALUES (LAST_INSERT_ID(), gender, birthday, photo_id, NOW(), hometown);

    IF _rollback
        THEN SET result = CONCAT('Ошибка: ', code_err, '\nТекст ошибки: ', text_err);
        ROLLBACK ;
    ELSE
        SET result = 'O.K.';
        COMMIT ;
    END IF;
END;
DELIMITER ;

# Wrong call
CALL user_add('New',
    'NewBie',
    'newbie@mail.ru',
    '9176162233',
    'M',
    'Moscow',
    -25,
    '1986-09-25',
    @result_of_trnsaction);
SELECT @result_of_trnsaction;

CALL user_add('New',
              'NewBie',
              'newbie@mail.ru',
              '9176162233',
              'M',
              'Moscow',
              25,
              '1986-09-25',
              @result_of_trnsaction);
SELECT @result_of_trnsaction;

DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers
(
IN input INT
)
BEGIN
    DECLARE n INT;
    DECLARE result VARCHAR(45) DEFAULT '';
    SET n = input;

    REPEAT
        SET result = CONCAT(result, n, ',');
        SET n = n - 1;
    UNTIL n = 1
    END REPEAT;
    SET result = CONCAT(result, n);
    SELECT result;
END;
DELIMITER ;

CALL print_numbers(4);