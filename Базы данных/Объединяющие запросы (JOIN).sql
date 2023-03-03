-- Объединение таблиц
-- выведем имена, фамилии и адреса всех сотрудников
select first_name, last_name, address from staff s 
left join address a on s.address_id = a.address_id;

-- определим количество продаж каждого продавца
select s.last_name, count(amount) from payment p 
left join staff s on p.staff_id = s.staff_id 
group by s.last_name;

-- посчитаем сколько актеров играло в каждом фильме
select title, count(actor_id) actor_q from film f
join film_actor a  on f.film_id = a.film_id 
group by f.title 
order by actor_q desc;

-- сколько копий фильмов со словом Super в названии есть в наличии
select title, count(inventory_id) from film f
join inventory i on f.film_id = i.film_id 
where title like '%Super%'
group by title;

-- выведем список покупателей с колличеством их покупок в порядке убывания
select c.last_name n, count(p.amount) amount from customer c 
left join payment p on c.customer_id = p.customer_id 
group by n 
order by amount desc;

-- выведем имена и почтовые адреса всех покупателей из России
select c.last_name, c.first_name, c.email from customer c
join address a on c.address_id = a.address_id 
join city on a.city_id = city.city_id 
join country co on city.city_id = co.country_id 
where country = 'Russian Federation';
