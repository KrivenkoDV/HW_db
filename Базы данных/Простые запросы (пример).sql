-- все поля из таблицы film
select * from film;

-- выбираем столбец title из таблицы film
select title from film;

-- выбираем 2 столбца из таблицы film
select title, release_year from film;

-- distinct - выводит только уникальные результаты столбца
select distinct rating from film;


-- Примеры с арифметикой
-- результаты поиска, колонку умножаем *70
select amount * 70 from payment;

-- результаты поиска, из значений колонки вычитаем значения другой колонки
select return_date - rental_date from rental;

-- where
-- найдем фильмы, вышедшие после 2000
select title, release_year from film
where release_year >= 2000;

-- найдем сотрудников, которые сейчас работают
select first_name, last_name, active from staff
where active = true;

-- критерий active не обязательно должен входить в выборку
select first_name, last_name from staff
where active = true;

-- найдем id, имена, фамилии актеров, которых зовут Joe
select actor_id, first_name, last_name from actor
where first_name = 'Joe';

-- найдем всех сотрудников, которые работают не во втором магазине
select first_name, last_name from staff
where store_id != 2;

-- найдем только работающих сотрудников из всех магазинов, кроме 1
select first_name, last_name from staff
where active = true and not store_id = 1;

-- найдем фильмы, цена проката которых меньше 0.99, а цена возмещения меньше 9.99
select title, rental_rate, replacement_cost from film
where rental_rate <= 0.99 and replacement_cost <= 9.99;

-- найдем фильмы аналогичные предыдущему примеру или(or) продолжительностью меньше 50 минут 
select title, length, rental_rate, replacement_cost from film
where rental_rate <= 0.99 and replacement_cost <= 9.99 or length < 50;


-- in / not in
-- найдем фильмы с рейтингом R, NC-17
select title, description, rating from film
where rating in ('R', 'NC-17');

-- найдем недетские фильмы
select title, description, rating from film
where rating not in ('G', 'PG');


-- BETWEN
-- в диапазоне (включая границы)
select title, rental_rate from film
where rental_rate between 0.99 and 3;

-- вне диапазона (границы тоже инвертируются => не включая границы)
select title, rental_rate from film
where rental_rate not between 0.99 and 3;

-- LIKE
-- найдем фильм, в описании которого есть Scientist
select title, description from film
where description like '%Scientist%';

-- найдем ID, имена, фамилии актеров, фамилия которых содержит gen
select actor_id, first_name, last_name from actor
where last_name like '%gen%'

-- найдем ID, имена, фамилии актеров, фамилия которых оканчивается на gen
-- если в запросе ставим вместо % знак _, то будет искать +1 символ к тексту %gen_
select actor_id, first_name, last_name from actor
where last_name like '%gen'


-- ORDER BY 
-- отсортируем фильмы по цене проката (по умолчанию значения сортируются по возростанию)
select title, rental_rate from film
order by rental_rate;

-- по убыванию
select title, rental_rate from film
order by rental_rate desc;

-- сортируем по нескольким столбцам: продолжительности и цене проката
select title, length, rental_rate from film
order by length desc, rental_rate desc;

-- найдем ID, имена, фамилии актеров, чья фамилия содержит li,
-- отсортируем в алфавитном порядке по фамилии, затем по имени
select actor_id, first_name, last_name from actor
where last_name like '%li%'
order by last_name, first_name;


-- LIMIT
-- выведем первые 15 записей
select title, length, rental_rate from film
order by length desc, rental_rate 
limit 5;