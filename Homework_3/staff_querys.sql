USE lesson_3;

# Отсортируйте данные по полю заработная плата (salary) в
# порядке: убывания; возрастания
SELECT *
FROM staff
ORDER BY salary DESC;

SELECT *
FROM staff
ORDER BY salary;

# Выведите 5 максимальных заработных плат (saraly)
SELECT *
FROM staff
ORDER BY salary DESC
LIMIT 5;

# Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) AS total_salary
FROM staff
GROUP BY post;

# Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте
# от 24 до 49 лет включительно.
SELECT post, COUNT(age) AS '24-49'
FROM staff
WHERE post = 'Рабочий' AND age BETWEEN 24 AND 49;

# Найдите количество специальностей
SELECT COUNT(DISTINCT post)
FROM staff;

# Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT post, AVG(age) AS young_staff
FROM staff
GROUP BY post
HAVING young_staff <= 30;

# Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых
# сотрудника по ЗП внутри каждой должности)
SELECT post, top_employeer, salary
FROM
    (SELECT post,
            CONCAT(firstname, ' ', lastname) AS top_employeer,
            salary,
            ROW_NUMBER() over (PARTITION BY post ORDER BY salary DESC) as row_num
     FROM staff) AS selected
WHERE row_num <= 2;