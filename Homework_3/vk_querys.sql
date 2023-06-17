USE lesson_4;

# -- Посчитать количество документов у каждого пользователя
SELECT COUNT(id) AS doc_count,
       user_id,
       (SELECT CONCAT(firstname, ' ', lastname)
            FROM users, media
            WHERE users.id = media.user_id) AS user
FROM media
WHERE filename LIKE '%.doc%'
GROUP BY user_id
ORDER BY doc_count, user;

# -- Посчитать лайки для моих документов (моих медиа)
SELECT COUNT(id) AS likes_count,
    (SELECT CONCAT(lastname, ' ', firstname)
        FROM users
        WHERE id = 1) AS user
FROM likes
WHERE media_id IN (SELECT id
                         FROM media
                         WHERE media.user_id = 1);
