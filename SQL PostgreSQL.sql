--=============== ������ 6. POSTGRESQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� SQL-������, ������� ������� ��� ���������� � ������� 
--�� ����������� ��������� "Behind the Scenes".

explain analyze --0,028

Select film_id, title, special_features from film
where array_position (special_features, 'Behind the Scenes') is not null 

--������� �2
--�������� ��� 2 �������� ������ ������� � ��������� "Behind the Scenes",
--��������� ������ ������� ��� ��������� ����� SQL ��� ������ �������� � �������.


explain analyze --0,03

Select * from film
where 'Behind the Scenes' = any (special_features);



explain analyze --0,021

Select * from film
where special_features && array ['Behind the Scenes'];



--������� �3
--��� ������� ���������� ���������� ������� �� ���� � ������ ������� 
--�� ����������� ��������� "Behind the Scenes.

--������������ ������� ��� ���������� �������: ����������� ������ �� ������� 1, 
--���������� � CTE. CTE ���������� ������������ ��� ������� �������.


explain analyze --24,6

with cte_film as(
Select * from film
where special_features @> array ['Behind the Scenes'])
select customer_id, count (film_id) from inventory i
inner join cte_film using (film_id)
inner join rental using (inventory_id)
group by customer_id
order by customer_id





--������� �4
--��� ������� ���������� ���������� ������� �� ���� � ������ �������
-- �� ����������� ��������� "Behind the Scenes".

--������������ ������� ��� ���������� �������: ����������� ������ �� ������� 1,
--���������� � ���������, ������� ���������� ������������ ��� ������� �������.



explain analyze --14,8

select customer_id, count (film_id) from inventory i
inner join 
(Select * from film
where special_features @> array ['Behind the Scenes']) t
using (film_id)
inner join rental using (inventory_id)
group by customer_id
order by customer_id




--������� �5
--�������� ����������������� ������������� � �������� �� ����������� �������
--� �������� ������ ��� ���������� ������������������ �������������


create materialized view dz_m as
with cte_film as(
Select * from film
where special_features @> array ['Behind the Scenes'])
select customer_id, count (film_id) from inventory i
inner join cte_film using (film_id)
inner join rental using (inventory_id)
group by customer_id

select * from dz_m 

--������� �6
--� ������� explain analyze ��������� ������ �������� ���������� ��������
-- �� ���������� ������� � �������� �� �������:

--1. ����� ���������� ��� �������� ����� SQL, ������������ ��� ���������� ��������� �������, 
--   ����� �������� � ������� ���������� �������
where special_features && array ['Behind the Scenes'];

--2. ����� ������� ���������� �������� �������: 
--   � �������������� CTE ��� � �������������� ����������
��c���� � �������������� ����������




--======== �������������� ����� ==============

--������� �1
--���������� ��� ������� � ����� ������ �� ����� ���������

--������� �2
--��������� ������� ������� �������� ��� ������� ����������
--�������� � ����� ������ ������� ����� ����������.

--������� �3
--��� ������� �������� ���������� � �������� ����� SQL-�������� ��������� ������������� ����������:
-- 1. ����, � ������� ���������� ������ ����� ������� (���� � ������� ���-�����-����)
-- 2. ���������� ������� ������ � ������ � ���� ����
-- 3. ����, � ������� ������� ������� �� ���������� ����� (���� � ������� ���-�����-����)
-- 4. ����� ������� � ���� ����




