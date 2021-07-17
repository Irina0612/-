--=============== МОДУЛЬ 6. POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Напишите SQL-запрос, который выводит всю информацию о фильмах 
--со специальным атрибутом "Behind the Scenes".

explain analyze --0,028

Select film_id, title, special_features from film
where array_position (special_features, 'Behind the Scenes') is not null 

--ЗАДАНИЕ №2
--Напишите еще 2 варианта поиска фильмов с атрибутом "Behind the Scenes",
--используя другие функции или операторы языка SQL для поиска значения в массиве.


explain analyze --0,03

Select * from film
where 'Behind the Scenes' = any (special_features);



explain analyze --0,021

Select * from film
where special_features && array ['Behind the Scenes'];



--ЗАДАНИЕ №3
--Для каждого покупателя посчитайте сколько он брал в аренду фильмов 
--со специальным атрибутом "Behind the Scenes.

--Обязательное условие для выполнения задания: используйте запрос из задания 1, 
--помещенный в CTE. CTE необходимо использовать для решения задания.


explain analyze --24,6

with cte_film as(
Select * from film
where special_features @> array ['Behind the Scenes'])
select customer_id, count (film_id) from inventory i
inner join cte_film using (film_id)
inner join rental using (inventory_id)
group by customer_id
order by customer_id





--ЗАДАНИЕ №4
--Для каждого покупателя посчитайте сколько он брал в аренду фильмов
-- со специальным атрибутом "Behind the Scenes".

--Обязательное условие для выполнения задания: используйте запрос из задания 1,
--помещенный в подзапрос, который необходимо использовать для решения задания.



explain analyze --14,8

select customer_id, count (film_id) from inventory i
inner join 
(Select * from film
where special_features @> array ['Behind the Scenes']) t
using (film_id)
inner join rental using (inventory_id)
group by customer_id
order by customer_id




--ЗАДАНИЕ №5
--Создайте материализованное представление с запросом из предыдущего задания
--и напишите запрос для обновления материализованного представления


create materialized view dz_m as
with cte_film as(
Select * from film
where special_features @> array ['Behind the Scenes'])
select customer_id, count (film_id) from inventory i
inner join cte_film using (film_id)
inner join rental using (inventory_id)
group by customer_id

select * from dz_m 

--ЗАДАНИЕ №6
--С помощью explain analyze проведите анализ скорости выполнения запросов
-- из предыдущих заданий и ответьте на вопросы:

--1. Каким оператором или функцией языка SQL, используемых при выполнении домашнего задания, 
--   поиск значения в массиве происходит быстрее
where special_features && array ['Behind the Scenes'];

--2. какой вариант вычислений работает быстрее: 
--   с использованием CTE или с использованием подзапроса
Быcтрее с использованием подзапроса




--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выполняйте это задание в форме ответа на сайте Нетологии

--ЗАДАНИЕ №2
--Используя оконную функцию выведите для каждого сотрудника
--сведения о самой первой продаже этого сотрудника.

--ЗАДАНИЕ №3
--Для каждого магазина определите и выведите одним SQL-запросом следующие аналитические показатели:
-- 1. день, в который арендовали больше всего фильмов (день в формате год-месяц-день)
-- 2. количество фильмов взятых в аренду в этот день
-- 3. день, в который продали фильмов на наименьшую сумму (день в формате год-месяц-день)
-- 4. сумму продажи в этот день




