USE lesson_4;

# Вывести название и цену для всех анализов, которые продавались 5 февраля 2020
# и всю следующую неделю.
SELECT an_name,an_price, ord_datetime
FROM analysis
JOIN orders o ON analysis.an_id = o.ord_an
WHERE o.ord_datetime BETWEEN '2020-02-5' AND '2020-02-13'
GROUP BY ord_datetime, an_price, an_name;
