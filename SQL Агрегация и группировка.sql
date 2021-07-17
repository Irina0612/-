--=============== ������ 3. ������ SQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

select * from film_category 
--======== �������� ����� ==============

--������� �1
--�������� ��� ������� ���������� ��� ����� ����������, 
--����� � ������ ����������.
select concat(first_name, ' ', last_name) "���", address, city, country 
from customer 
	inner join address using (address_id) 
	inner join city using (city_id) 
	inner join country using (country_id)

	

--������� �2
--� ������� SQL-������� ���������� ��� ������� �������� ���������� ��� �����������.
select store_id, count (customer_id) "���������� �����������" from customer 
group by store_id


--����������� ������ � �������� ������ �� ��������, 
--� ������� ���������� ����������� ������ 300-��.
--��� ������� ����������� ���������� �� ��������������� ������� 
--� �������������� ������� ���������.

select store_id, count (customer_id) "���������� �����������" from customer 
group by store_id
having count (customer_id) > 300


-- ����������� ������, ������� � ���� ���������� � ������ ��������, 
--� ����� ������� � ��� ��������, ������� �������� � ���� ��������.


select store_id, count (customer.customer_id) "���������� �����������", city, concat (staff.first_name, ' ', staff.last_name) "���"
from customer 
inner join store using (store_id) 
join address on store.address_id = address.address_id 
inner join city using (city_id)
inner join staff using (store_id)
group by store_id,  city,  "���"
having count (customer.customer_id) > 300




--������� �3
--�������� ���-5 �����������, 
--������� ����� � ������ �� �� ����� ���������� ���������� �������

select count(rental_id) "���������� �������", concat(first_name, ' ', last_name) "���"
from rental
inner join customer using (customer_id) 
group by customer_id
order by count(rental_id) desc 
limit 5



--������� �4
--���������� ��� ������� ���������� 4 ������������� ����������:
--  1. ���������� �������, ������� �� ���� � ������
--  2. ����� ��������� �������� �� ������ ���� ������� (�������� ��������� �� ������ �����)
--  3. ����������� �������� ������� �� ������ ������
--  4. ������������ �������� ������� �� ������ ������

select concat(first_name, ' ', last_name) "��� � �������", max(amount) "������������ �������� �������", min(amount) "����������� �������� �������", round(sum(amount),0) "����� ��������� ��������",count(payment_id) "���������� �������" 
from payment
inner join customer using (customer_id)
group by customer_id

--������� �5
--��������� ������ �� ������� ������� ��������� ����� �������� ������������ ���� ������� ����� �������,
 --����� � ���������� �� ���� ��� � ����������� ���������� �������. 
 --��� ������� ���������� ������������ ��������� ������������.
 select a.city,b.city from city a
cross join city b 
where a.city <> b.city



--������� �6
--��������� ������ �� ������� rental � ���� ������ ������ � ������ (���� rental_date)
--� ���� �������� ������ (���� return_date), 
--��������� ��� ������� ���������� ������� ���������� ����, �� ������� ���������� ���������� ������.
 
 select customer_id, avg (extract(day from return_date-rental_date )) 
 from rental
 group by customer_id
 order by customer_id


--======== �������������� ����� ==============

--������� �1
--���������� ��� ������� ������ ������� ��� ��� ����� � ������ � �������� ����� ��������� ������ ������ �� �� �����.


select count(payment_id) "������� ��� �����", sum(amount) "�������� ����� ���������",title
from film
inner join inventory using (film_id) 
inner join rental using (inventory_id) 
inner join payment using (rental_id) 
group by film_id


--������� �2
--����������� ������ �� ����������� ������� � �������� � ������� ������� ������, ������� �� ���� �� ����� � ������.

select count(payment_id) "������� ��� �����", sum(amount) "�������� ����� ���������",title
from film
left join inventory using (film_id) 
left join rental using (inventory_id) 
left join payment using (rental_id) 
group by film_id
having count(inventory) = 0




--������� �3
--���������� ���������� ������, ����������� ������ ���������. �������� ����������� ������� "������".
--���� ���������� ������ ��������� 7300, �� �������� � ������� ����� "��", ����� ������ ���� �������� "���".

select staff_id,  count(staff_id) "���������� ������",
case
when count(staff_id) > 7300 then '��'
else '���'
end "������"
from payment 
group by staff_id






