-- Агрегирующие функции
-- найдем максимальную стоимость проката
select max(rental_rate) from film;

-- найдем максимальную и минимальную стоимость проката
select max(rental_rate), min(rental_rate) from film;

-- подсчет средней продолжительности фильма
select avg(length) from film;

-- сколько уникальных имен актеров?
select count(distinct first_name) from actor;

-- сколько всего актеров?
select count(first_name) from actor; 

-- посчитаем сумму и средние продажи по конкретному продавцу
select sum(amount), avg(amount) from payment
where staff_id =1;

-- Вложенные запросы
-- найдем все фильмы с продолжительностью выше среднего
select title, length from film
where length >= (select avg(length) from film);

-- найдем названия фильмов, стоимость которых не максимальная
select title, rental_rate from film
where rental_rate < (select max(rental_rate) from film)
order by rental_rate desc;

-- Группировки
-- посчитаем количество актеров в разрезе фамилий (найдем однофамильцев)
select last_name, count(*) from actor
group by last_name 
order by count(*) desc;

-- посчитаем количество фильмов в разрезе рейтингов (распределение рейтингов)
select rating, count(title) from film
group by rating
order by count(title) desc;

-- найдем максимальные продажи в разрезе продавцов
select staff_id, max(amount) from payment
group by staff_id;

-- найдем средние продажи каждого продавца каждому покупателю
select staff_id, customer_id, avg(amount) from payment
group by staff_id, customer_id
order by avg(amount) desc;

-- найдем среднюю продолжительность фильма в разрезе рейтингов в 2006 году
select rating, avg(length) from film
where release_year = 2006
group by rating;

-- Оператор HAVING
-- отберем только фамилии актеров, которые не повторяются
select last_name, count(*)  from actor
group by last_name 
having count(*) = 1;

-- отберем и посчитаем только фамилии актеров, которые повторяются
select last_name, count(*)  from actor
group by last_name 
having count(*) > 1
order by count(*) desc;

-- найдем фильмы, у которых есть Super в названии
-- и они сдавались в прокат суммарно более, чем на 5 дней
select title, sum(rental_duration) from film
where title like '%Super%'
group by title 
having sum(rental_duration) > 5;

-- тот же запрос но без where
select title, sum(rental_duration) from film
group by title 
having sum(rental_duration) > 5 and title like '%Super%';

-- Псевдонимы (столбцы, таблицы)
-- предыдущий запрос с псевдонимами
select title as t, sum(rental_duration) as sum_t from film as f
where title like '%Super%'  -- указывать полное имя
group by t
having sum(rental_duration) > 5; -- указывать полное имя
