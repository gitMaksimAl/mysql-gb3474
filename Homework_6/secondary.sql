USE vk_db;

# Создать процедуру, которая решает следующую задачу. Выбрать для одного
# пользователя 5 пользователей в случайной комбинации, которые удовлетворяют
# хотя бы одному критерию:
# а) из одного города
# б) состоят в одной группе
# в) друзья друзей
DROP PROCEDURE IF EXISTS friends_recommendations;
DELIMITER $$
CREATE PROCEDURE friends_recommendations
(
IN target_id BIGINT UNSIGNED
)
BEGIN
    -- same town
    SELECT CONCAT(firstname, ' ', lastname) AS fullname,
           hometown
    FROM users
    JOIN profiles ON users.id = profiles.user_id
    WHERE hometown =
END $$
DELIMITER ;

SELECT CONCAT(firstname, ' ', lastname) AS fullname,
       hometown
FROM users
JOIN profiles p ON users.id = p.user_id
WHERE hometown = (SELECT hometown FROM profiles WHERE user_id = 102) AND user_id != 102;

SELECT p2.user_id FROM profiles p1
JOIN profiles p2 ON p1.hometown = p2.hometown
WHERE p1.user_id = 102 AND p2.user_id != 102;
SELECT * FROM profiles p1
JOIN profiles p2 ON p1.hometown = p2.hometown;
SELECT * FROM users_communities uc1
JOIN users_communities uc2 ON uc1.community_id = uc2.community_id;
