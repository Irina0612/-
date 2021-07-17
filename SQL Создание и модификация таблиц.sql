--=============== ������ 4. ���������� � SQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO "SQL 4";


--======== �������� ����� ==============

--������� �1
--���� ������: ���� ����������� � �������� ����, �� �������� ����� ������� � �������:
--�������_�������, 
--���� ����������� � ���������� ��� ���������� �������, �� �������� ����� ����� � � ��� �������� �������.


-- ������������� ���� ������ ��� ��������� ���������:
-- 1. ���� (� ������ ����������, ����������� � ��)
-- 2. ���������� (� ������ �������, ���������� � ��)
-- 3. ������ (� ������ ������, �������� � ��)


--������� ���������:
-- �� ����� ����� ����� �������� ��������� �����������
-- ���� ���������� ����� ������� � ��������� �����
-- ������ ������ ����� �������� �� ���������� �����������

 
--���������� � ��������-������������:
-- ������������� �������� ������ ������������� ���������������
-- ������������ ��������� �� ������ ��������� null �������� � �� ������ ����������� ��������� � ��������� ���������
 
--�������� ������� �����
CREATE TABLE language(
language_id serial PRIMARY key,
language_name varchar(50) UNIQUE NOT NULL
)


--�������� ������ � ������� �����
insert into language (language_name)
values
('Russian')


--�������� ������� ����������

CREATE TABLE nation(
nation_id serial PRIMARY key,
nation_name varchar(50) UNIQUE NOT NULL
)

--�������� ������ � ������� ����������
insert into nation (nation_name)
values
('American')



--�������� ������� ������

CREATE TABLE country (
country_id serial PRIMARY key,
country_name varchar(50) UNIQUE NOT NULL
)

--�������� ������ � ������� ������
insert into country (country_name)
values
('Russia')


--�������� ������ ������� �� �������

CREATE TABLE language_nation (
language_id int2 not null references language (language_id),
nation_id int2 not null references nation (nation_id)
)

--�������� ������ � ������� �� �������

insert into  language_nation (language_id, nation_id)
values
('1', '1')


--�������� ������ ������� �� �������

CREATE TABLE country_nation (
country_id int2 not null references country (country_id),
nation_id int2 not null references nation (nation_id)
)

--�������� ������ � ������� �� �������

insert into  country_nation (country_id, nation_id)
values
('1', '1')


--======== �������������� ����� ==============


--������� �1 
--�������� ����� ������� film_new �� ���������� ������:
--�   	film_name - �������� ������ - ��� ������ varchar(255) � ����������� not null
--�   	film_year - ��� ������� ������ - ��� ������ integer, �������, ��� �������� ������ ���� ������ 0
--�   	film_rental_rate - ��������� ������ ������ - ��� ������ numeric(4,2), �������� �� ��������� 0.99
--�   	film_duration - ������������ ������ � ������� - ��� ������ integer, ����������� not null � �������, ��� �������� ������ ���� ������ 0
--���� ��������� � �������� ����, �� ����� ��������� ������� ������� ������������ ����� �����.

CREATE TABLE film_new (
film_name varchar(255) not null, 
film_year integer check (film_year > 0),
film_rental_rate numeric(4,2) default 0.99,
film_duration integer not null check (film_duration > 0)
)

--������� �2 
--��������� ������� film_new ������� � ������� SQL-�������, ��� �������� ������������� ������� ������:
--�       film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--�       film_year - array[1994, 1999, 1985, 1994, 1993]
--�       film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--�   	  film_duration - array[142, 189, 116, 142, 195]

insert into  film_new (film_name, film_year, film_rental_rate, film_duration)
select unnest (array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']),
unnest (array[1994, 1999, 1985, 1994, 1993]),
unnest (array[2.99, 0.99, 1.99, 2.99, 3.99]),
unnest (array[142, 189, 116, 142, 195])

select *from film_new

--������� �3
--�������� ��������� ������ ������� � ������� film_new � ������ ����������, 
--��� ��������� ������ ���� ������� ��������� �� 1.41
update film_new 
set film_rental_rate = film_rental_rate + 1.41


--������� �4
--����� � ��������� "Back to the Future" ��� ���� � ������, 
--������� ������ � ���� ������� �� ������� film_new

delete from film_new
where film_name = 'Back to the Future'

--������� �5
--�������� � ������� film_new ������ � ����� ������ ����� ������


insert into  film_new (film_name, film_year, film_rental_rate, film_duration)
values ('Up', 2008, 2.99, 160)


--������� �6
--�������� SQL-������, ������� ������� ��� ������� �� ������� film_new, 
--� ����� ����� ����������� ������� "������������ ������ � �����", ���������� �� �������

select *, round (film_duration / 60.0 ,1) as  film_duration_h  from film_new 


--������� �7 
--������� ������� film_new

drop table film_new cascade
