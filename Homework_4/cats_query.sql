USE lesson_4;
# Используя JOIN-ы, выполните следующие операции:
# Вывести всех котиков по магазинам по id (условие соединения shops.id
# = cats.shops_id)
SELECT
    name,
    shopname
FROM cats
JOIN shops s ON s.id = cats.shops_id;

# Вывести магазин, в котором продается кот “Мурзик”
# (попробуйте выполнить 2 способами)
SELECT
    shopname,
    name
FROM shops
JOIN cats c on shops.id = c.shops_id
WHERE name = 'Murzik';

SELECT
    shopname,
    name
FROM (SELECT * FROM cats WHERE name = 'Murzik') cat
JOIN shops shop ON cat.shops_id = shop.id;

# Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
SELECT
    shopname
FROM shops
WHERE shops.id NOT IN (SELECT shops_id FROM cats WHERE name IN ('Murzik', 'Zuza'));

SELECT shopname, id
FROM shops
LEFT OUTER JOIN (SELECT shops_id FROM cats WHERE name IN ('Murzik', 'Zuza')) AS ex
ON shops.id = ex.shops_id
WHERE shops_id IS NULL;
