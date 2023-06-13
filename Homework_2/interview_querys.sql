USE lesson2;

-- №1.	Используя оператор ALTER TABLE, установите внешний ключ в одной из таблиц.
ALTER TABLE posts
ADD FOREIGN KEY (user_id) REFERENCES clients(id);

-- №2.	Без оператора JOIN, верните заголовок публикации, текст с описанием,
-- идентификатор клиента, опубликовавшего публикацию и логин данного клиента.
SELECT title, full_text, user_id, login
FROM posts AS p, clients AS c
WHERE p.user_id = c.id;

-- №3.	Выполните поиск  по публикациям, автором котоырх является клиент "Mikle".
SELECT title, login
FROM posts AS p, clients AS c
WHERE c.login = 'Mikle' AND c.id = p.user_id;