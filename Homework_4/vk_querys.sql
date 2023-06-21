USE vk_db;

# Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT COUNT(likes.id) total_likes
FROM likes
JOIN media m ON m.id = likes.media_id
JOIN profiles p on m.id = p.photo_id
WHERE (DATEDIFF(CURDATE(), p.birthday) / 365) < 12;

# Определить кто больше поставил лайков (всего): мужчины или женщины
SELECT COUNT(likes.id) all_likes, p.gender
FROM likes
JOIN profiles p on likes.user_id = p.user_id
GROUP BY gender;

# Вывести всех пользователей, которые не отправляли сообщения.
SELECT CONCAT(firstname, ' ', lastname) fullname, COUNT(m.id) send_mesage
FROM users
LEFT JOIN messages m on users.id = m.from_user_id
GROUP BY fullname
HAVING send_mesage = 0;
