USE lesson_3;

SELECT * FROM staff;

# Ранжирование
# Вывести список всех сотрудников и указать место в рейтинге
SELECT
    salary,
    post,
    CONCAT(firstname, ' ', lastname) fullname,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS `dense_rank`
FROM staff;

# Ранжирование
# Вывести список всех сотрудников и указать место в рейтинге
# НО по каждой должности
SELECT
    salary,
    post,
    CONCAT(firstname, ' ', lastname) fullname,
    DENSE_RANK() OVER ( PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff;

# Найдем самых высокооплачиваемых сотрудников
SELECT
    *
FROM (SELECT
    salary,
    post,
    CONCAT(firstname, ' ', lastname) fullname,
    DENSE_RANK() OVER ( PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff) top
WHERE `dense_rank` = 1;

# ТОП 2 самых высоко оплачиваемых
SELECT
    *
FROM (SELECT
          salary,
          post,
          CONCAT(firstname, ' ', lastname) fullname,
          DENSE_RANK() OVER ( PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
      FROM staff) top
WHERE `dense_rank` = 1 OR `dense_rank` = 2; -- IN (1, 2)


# Агреация
# Суммарная зарплата
# Средняя зарплата
# Процентное соотношение зп сотрудника от всех зарплат
SELECT
    post,
    salary,
    CONCAT(firstname, ' ', lastname) fullname,
    SUM(salary) OVER w AS sum_salary,
    ROUND(AVG(salary) OVER w, 2) AS avarage_salary, -- AVG(salary) OVER w AS ...
    ROUND(salary * 100 / SUM(salary) OVER w , 2) AS percent_of_total
FROM staff
WINDOW w AS (PARTITION BY post); -- alias of window

# VIEW
# Количество сотрудников постб средняя зп.
CREATE OR REPLACE VIEW count_post AS
SELECT
    COUNT(*) staff_count,
    post,
    ROUND(AVG(salary), 2) avg
FROM staff
GROUP BY post
ORDER BY staff_count;

SELECT * FROM count_post;