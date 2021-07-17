--=============== ������ 2. ������ � ������ ������ =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� ���������� �������� �������� �� ������� �������
select distinct district from address  


--������� �2
--����������� ������ �� ����������� �������, ����� ������ ������� ������ �� �������, 
--�������� ������� ���������� �� "K" � ������������� �� "a", � �������� �� �������� ��������
select distinct district from address 
where district like 'K%a' and district not like '% %'


--������� �3
--�������� �� ������� �������� �� ������ ������� ���������� �� ��������, ������� ����������� 
--� ���������� � 17 ����� 2007 ���� �� 19 ����� 2007 ���� ������������, 
--� ��������� ������� ��������� 1.00.
--������� ����� ������������� �� ���� �������.

select payment_id, payment_date, amount 
from payment
where payment_date::date between '2007-03-17' and '2007-03-19'
and amount > 1
order by payment_date


--������� �4
-- �������� ���������� � 10-�� ��������� �������� �� ������ �������.

select payment_id, payment_date, amount 
from payment
order by payment_date desc 
limit 10 


--������� �5
--�������� ��������� ���������� �� �����������:
--  1. ������� � ��� (� ����� ������� ����� ������)
--  2. ����������� �����
--  3. ����� �������� ���� email
--  4. ���� ���������� ���������� ������ � ���������� (��� �������)
--������ ������� ������� ������������ �� ������� �����.

select first_name || ' ' || last_name "��� � �������", email, length(email) "����� email", concat(date_part('day', "last_update"), '.', date_part('month', "last_update"), '.', date_part('year', "last_update")) "����"  
from customer



--������� �6
--�������� ����� �������� �������� �����������, ����� ������� Kelly ��� Willie.
--��� ����� � ������� � ����� �� ������� �������� ������ ���� ���������� � ������� �������.

select upper (first_name), upper (last_name),active
from customer
where (first_name = 'Willie' or first_name = 'Kelly') and active = '1'
order by last_update
limit 4



--======== �������������� ����� ==============

--������� �1
--�������� ����� �������� ���������� � �������, � ������� ������� "R" 
--� ��������� ������ ������� �� 0.00 �� 3.00 ������������, 
--� ����� ������ c ��������� "PG-13" � ���������� ������ ������ ��� ������ 4.00.

select film_id, title, description, rating,rental_rate
from film
where (rating::text = 'R' and "rental_rate" between 0.00 and 3.00)
or (rating::text = 'PG-13' and rental_rate >= 4.00)



--������� �2
--�������� ���������� � ��� ������� � ����� ������� ��������� ������.

select film_id, title, description, rating,rental_rate from film
order by length (description) desc
limit 3



--������� �3
-- �������� Email ������� ����������, �������� �������� Email �� 2 ��������� �������:
--� ������ ������� ������ ���� ��������, ��������� �� @, 
--�� ������ ������� ������ ���� ��������, ��������� ����� @.

select customer_id, email, split_part (email, '@', 1) "email before @", split_part (email, '@', 2) "email after @"  from customer 



--������� �4
--����������� ������ �� ����������� �������, �������������� �������� � ����� ��������: 
--������ ����� ������ ���� ���������, ��������� ���������.

select customer_id, email, 
concat (upper (left(split_part (email, '@', 1), 1 )), substring (split_part (email, '@', 1), 2)) "email before @", 
concat (upper (left(split_part (email, '@', 2), 1)), substring (split_part (email, '@', 2), 2)) "email after @" from customer 



