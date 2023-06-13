USE lesson2;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS orders;

# Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
CREATE TABLE IF NOT EXISTS sales
    (id INT PRIMARY KEY AUTO_INCREMENT,
    order_rate DATE,
    count_product INT);

INSERT INTO sales
    (order_rate, count_product)
VALUES
    ('2022-01-01', 156),
    ('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);

# Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300
SELECT id,
       CASE
           WHEN count_product < 100 THEN 'Маленький заказ'
           WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
           WHEN count_product > 300 THEN 'Большой заказ'
           ELSE ''
       END AS sale_type
FROM sales;

# Создайте таблицу “orders”
CREATE TABLE IF NOT EXISTS orders
(id INT PRIMARY KEY AUTO_INCREMENT,
 employee_id CHAR(3),
 amount DECIMAL(5,2),
 order_status VARCHAR(9));

# , заполните ее значениями.
INSERT INTO orders
    (employee_id, amount, order_status)
VALUES
    ('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');

# Покажите “полный” статус заказа, используя оператор CASE
SELECT id,
       CASE
           WHEN order_status = 'OPEN' THEN 'Order is in open state'
           WHEN order_status = 'CLOSED' THEN 'Order is closed'
           WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
           ELSE ''
       END AS full_order_status
FROM orders;
