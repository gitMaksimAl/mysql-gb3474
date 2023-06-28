USE vk_db;

# - Получите друзей пользователя с id=1
# - (решение задачи с помощью представления “друзья”)
CREATE OR REPLACE VIEW friends AS
    SELECT CONCAT(firstname, ' ', lastname) AS friend
    FROM users
    JOIN friend_requests fr ON users.id = fr.initiator_user_id
    WHERE target_user_id = 1 AND status = 'approved';

SELECT * FROM friends;

# - Создайте представление, в котором будут выводится все сообщения, в которых
# принимал участие пользователь с id = 1
CREATE OR REPLACE VIEW conversation AS
    SELECT messages.id, created_at, from_user_id, to_user_id, body
    FROM messages
    LEFT OUTER JOIN users u ON u.id = messages.from_user_id
    WHERE from_user_id = 1 OR to_user_id = 1
    ORDER BY from_user_id, created_at;

SELECT * FROM conversation;

# - Получите список медиафайлов пользователя с количеством
# лайков(media m, likes l ,users u)
SELECT filename, COUNT(l.id) likes_count
FROM users u
LEFT OUTER JOIN media m ON u.id = m.user_id
JOIN likes l ON m.id = l.media_id
WHERE m.user_id = 1
GROUP BY filename;

# -- Получите количество групп у пользователей
SELECT CONCAT(firstname, ' ', lastname) user,
       COUNT(uc.community_id) comunities_count
FROM users u
RIGHT JOIN users_communities uc on u.id = uc.user_id
GROUP BY user;

# 1. Создайте представление, в которое попадет информация о пользователях
# (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE OR REPLACE VIEW young_users AS
    SELECT firstname,
           lastname,
            hometown,
            gender
    FROM users u
    RIGHT JOIN profiles p on u.id = p.user_id
    WHERE (DATEDIFF(CURRENT_DATE, p.birthday) / 365) < 21;

SELECT * FROM young_users;

# 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
# ранжированный список пользователей, указав имя и фамилию пользователя,
# количество отправленных сообщений и место в рейтинге (первое место у
# пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
SELECT user, messages_count, DENSE_RANK() OVER (ORDER BY messages_count DESC) AS `rank`
FROM
(SELECT CONCAT(firstname, ' ', lastname) AS user,
       COUNT(m.id) AS messages_count
FROM users
RIGHT JOIN messages m on users.id = m.from_user_id
GROUP BY from_user_id) AS users_messages
GROUP BY messages_count, user;


# 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты
# отправления (created_at) и найдите разницу дат отправления между соседними
# сообщениями, получившегося списка. (используйте LEAD или LAG)
SELECT
    id,
    from_user_id,
    to_user_id,
    body,
    created_at,
    TIMEDIFF(LEAD(created_at) OVER (ORDER BY created_at), created_at) AS next_in
FROM messages;