--=============== МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Cделайте запрос к таблице payment. 
--Пронумеруйте все продажи от 1 до N по дате продажи.

select payment_id, payment_date,
row_number () over (order by payment_date) as row_number
from payment


--ЗАДАНИЕ №2
--Используя оконную функцию добавьте колонку с порядковым номером
--продажи для каждого покупателя,
--сортировка платежей должна быть по дате платежа.

select payment_id, payment_date, customer_id,
row_number () over (partition by customer_id order by payment_date) as row_number
from payment



--ЗАДАНИЕ №3
--Для каждого пользователя посчитайте нарастающим итогом сумму всех его платежей,
--сортировка платежей должна быть по дате платежа.

select payment_id, payment_date, customer_id,amount,
sum (amount) over (partition by customer_id order by payment_date) as sum_amount
from payment



--ЗАДАНИЕ №4
--Для каждого покупателя выведите данные о его последней оплате аренде.

select w.customer_id, w.payment_id, w.payment_date, w.amount
from 
(select * from (select max ("row_number"), t.customer_id as q
	from (				
	select payment_id, payment_date, customer_id, amount,
row_number () over (partition by customer_id order by payment_date) as row_number
		from payment) t 
	group by t.customer_id
	order by t.customer_id) as m
	join (				
	select payment_id, payment_date, customer_id, amount,
row_number () over (partition by customer_id order by payment_date) as row_number
		from payment) t on t.customer_id = q and max = row_number) as w
		

	

--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--С помощью оконной функции выведите для каждого сотрудника магазина
--стоимость продажи из предыдущей строки со значением по умолчанию 0.0
--с сортировкой по дате продажи


select staff_id,payment_id, payment_date, 
lag (amount, 1, 0.) over (partition by staff_id order by payment_date ),
amount
from payment


--ЗАДАНИЕ №2
--С помощью оконной функции выведите для каждого сотрудника сумму продаж за март 2007 года
--с нарастающим итогом по каждому сотруднику и по каждой дате продажи (дата без учета времени)
--с сортировкой по дате продажи


--ЗАДАНИЕ №3
--Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
-- 1. покупатель, арендовавший наибольшее количество фильмов
-- 2. покупатель, арендовавший фильмов на самую большую сумму
-- 3. покупатель, который последним арендовал фильм






