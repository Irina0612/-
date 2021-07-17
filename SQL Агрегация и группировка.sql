--=============== МОДУЛЬ 3. ОСНОВЫ SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

select * from film_category 
--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.
select concat(first_name, ' ', last_name) "фио", address, city, country 
from customer 
	inner join address using (address_id) 
	inner join city using (city_id) 
	inner join country using (country_id)

	

--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.
select store_id, count (customer_id) "Количество покупателей" from customer 
group by store_id


--Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.

select store_id, count (customer_id) "Количество покупателей" from customer 
group by store_id
having count (customer_id) > 300


-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.


select store_id, count (customer.customer_id) "Количество покупателей", city, concat (staff.first_name, ' ', staff.last_name) "фио"
from customer 
inner join store using (store_id) 
join address on store.address_id = address.address_id 
inner join city using (city_id)
inner join staff using (store_id)
group by store_id,  city,  "фио"
having count (customer.customer_id) > 300




--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

select count(rental_id) "количество фильмов", concat(first_name, ' ', last_name) "фио"
from rental
inner join customer using (customer_id) 
group by customer_id
order by count(rental_id) desc 
limit 5



--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма

select concat(first_name, ' ', last_name) "имя и фамилия", max(amount) "максимальное значение платежа", min(amount) "минимальное значение платежа", round(sum(amount),0) "общая стоимость платежей",count(payment_id) "количество фильмов" 
from payment
inner join customer using (customer_id)
group by customer_id

--ЗАДАНИЕ №5
--Используя данные из таблицы городов составьте одним запросом всевозможные пары городов таким образом,
 --чтобы в результате не было пар с одинаковыми названиями городов. 
 --Для решения необходимо использовать декартово произведение.
 select a.city,b.city from city a
cross join city b 
where a.city <> b.city



--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date)
--и дате возврата фильма (поле return_date), 
--вычислите для каждого покупателя среднее количество дней, за которые покупатель возвращает фильмы.
 
 select customer_id, avg (extract(day from return_date-rental_date )) 
 from rental
 group by customer_id
 order by customer_id


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.


select count(payment_id) "сколько раз брали", sum(amount) "значение общей стоимости",title
from film
inner join inventory using (film_id) 
inner join rental using (inventory_id) 
inner join payment using (rental_id) 
group by film_id


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью запроса фильмы, которые ни разу не брали в аренду.

select count(payment_id) "сколько раз брали", sum(amount) "значение общей стоимости",title
from film
left join inventory using (film_id) 
left join rental using (inventory_id) 
left join payment using (rental_id) 
group by film_id
having count(inventory) = 0




--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".

select staff_id,  count(staff_id) "Количество продаж",
case
when count(staff_id) > 7300 then 'Да'
else 'Нет'
end "Премия"
from payment 
group by staff_id






