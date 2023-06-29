USE vk_db;

# Создать процедуру, которая решает следующую задачу. Выбрать для одного
# пользователя 5 пользователей в случайной комбинации, которые удовлетворяют
# хотя бы одному критерию:
# а) из одного города
# б) состоят в одной группе
# в) друзья друзей
DROP PROCEDURE IF EXISTS friends_recommendations;
DELIMITER $$
CREATE PROCEDURE friends_recommendations()
BEGIN
    DECLARE target BIGINT UNSIGNED DEFAULT 1;
    SELECT CONCAT(firstname, ' ', lastname) AS you_may_know_them
    FROM users
    JOIN
        (SELECT p2.user_id FROM profiles p1
        JOIN profiles p2 ON p1.hometown = p2.hometown
        WHERE p1.user_id = target AND p2.user_id != target
        UNION
        SELECT uc2.user_id FROM users_communities uc1
        JOIN users_communities uc2 ON uc1.community_id = uc2.community_id
        WHERE uc1.user_id = target AND uc2.user_id != target
        UNION
        SELECT fr.initiator_user_id AS user_id FROM friend_requests AS fr
        JOIN friends ON fr.target_user_id = id
        WHERE fr.initiator_user_id != target AND status = 'approved'
        UNION
        SELECT fr.target_user_id AS user_id FROM friend_requests AS fr
        JOIN friends ON fr.initiator_user_id = id
        WHERE fr.target_user_id != target AND status = 'approved') AS id_s
    ON id = user_id;
END $$
DELIMITER ;

CALL friends_recommendations();

# Создать функцию, вычисляющей коэффициент популярности
# пользователя (по количеству друзей)
DROP FUNCTION IF EXISTS get_rating;
DELIMITER $$
CREATE FUNCTION get_rating(user_id BIGINT UNSIGNED)
RETURNS FLOAT
READS SQL DATA
BEGIN
        DECLARE request_to INT;
        DECLARE request_from INT;
        SELECT COUNT(target_user_id) INTO request_to FROM friend_requests
            WHERE target_user_id = user_id AND status = 'approved';
        SELECT COUNT(initiator_user_id) INTO request_from FROM friend_requests
        WHERE initiator_user_id = user_id AND status = 'approved';
        RETURN IF(request_from <> 0, request_to / request_from, 0);
END $$;
DELIMITER ;

SELECT get_rating(11);

# Создайте хранимую функцию hello(), которая будет возвращать приветствие, в
# зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
# возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
# фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
# с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS hello;
DELIMITER $$
CREATE FUNCTION hello()
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
    DECLARE morning VARCHAR(25) DEFAULT 'Доброе утро.';
    DECLARE afternoon VARCHAR(25) DEFAULT 'Добрый день.';
    DECLARE evening VARCHAR(25) DEFAULT 'Добрый вечер.';
    DECLARE night VARCHAR(25) DEFAULT 'Доброй ночи.';
    IF CURRENT_TIME BETWEEN '00:00:00' AND '06:00:00'
        THEN RETURN night;
    ELSEIF CURRENT_TIME BETWEEN '06:00:00' AND '12:00:00'
        THEN RETURN morning;
    ELSEIF CURRENT_TIME BETWEEN '12:00:00' AND '18:00:00'
        THEN RETURN afternoon;
    ELSE RETURN evening;
    END IF;
end $$;
DELIMITER ;

SELECT hello();

# ***Создайте таблицу logs типа Archive. Пусть при каждом создании записи в
# таблицах users, communities и messages в таблицу logs помещается время и
# дата создания записи, название таблицы, идентификатор
# первичного ключа. (Триггеры*)
CREATE TABLE IF NOT EXISTS logs
    (modified_by TIMESTAMP,
    table_name VARCHAR(15),
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT);

CREATE TRIGGER add_note AFTER INSERT ON users