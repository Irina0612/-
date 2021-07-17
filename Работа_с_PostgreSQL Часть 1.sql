--=============== ������ 5. ������ � POSTGRESQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--C������� ������ � ������� payment. 
--������������ ��� ������� �� 1 �� N �� ���� �������.

select payment_id, payment_date,
row_number () over (order by payment_date) as row_number
from payment


--������� �2
--��������� ������� ������� �������� ������� � ���������� �������
--������� ��� ������� ����������,
--���������� �������� ������ ���� �� ���� �������.

select payment_id, payment_date, customer_id,
row_number () over (partition by customer_id order by payment_date) as row_number
from payment



--������� �3
--��� ������� ������������ ���������� ����������� ������ ����� ���� ��� ��������,
--���������� �������� ������ ���� �� ���� �������.

select payment_id, payment_date, customer_id,amount,
sum (amount) over (partition by customer_id order by payment_date) as sum_amount
from payment



--������� �4
--��� ������� ���������� �������� ������ � ��� ��������� ������ ������.

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
		

	

--======== �������������� ����� ==============

--������� �1
--� ������� ������� ������� �������� ��� ������� ���������� ��������
--��������� ������� �� ���������� ������ �� ��������� �� ��������� 0.0
--� ����������� �� ���� �������


select staff_id,payment_id, payment_date, 
lag (amount, 1, 0.) over (partition by staff_id order by payment_date ),
amount
from payment


--������� �2
--� ������� ������� ������� �������� ��� ������� ���������� ����� ������ �� ���� 2007 ����
--� ����������� ������ �� ������� ���������� � �� ������ ���� ������� (���� ��� ����� �������)
--� ����������� �� ���� �������


--������� �3
--��� ������ ������ ���������� � �������� ����� SQL-�������� �����������, ������� �������� ��� �������:
-- 1. ����������, ������������ ���������� ���������� �������
-- 2. ����������, ������������ ������� �� ����� ������� �����
-- 3. ����������, ������� ��������� ��������� �����






