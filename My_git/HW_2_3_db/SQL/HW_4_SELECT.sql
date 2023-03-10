-- количество исполнителей в каждом жанре;
select name, count(musicians_id) mus from mus_genres mg
join links_genres lg on mg.id = lg.mus_genres_id
group by mg.name  
order by count(lg.musicians_id) desc

-- количество треков, вошедших в альбомы 2019-2020 годов;
select ma.name, count(mus_alboms_id) tracks from mus_alboms ma
join mus_tracks mt on mt.mus_alboms_id = ma.id
where ma.year in ('2019', '2020')
group by ma.name

---- средняя продолжительность треков по каждому альбому;
select ma.name, avg(time_track) from mus_tracks mt
join mus_alboms ma on ma.id = mt.mus_alboms_id
group by ma.name 

-- все исполнители, которые не выпустили альбомы в 2020 году;
select m.name, ma.name albom from musicians m 
join links_alboms la on musicians_id = m.id
join mus_alboms ma on mus_alboms_id = ma.id
where ma.year <> '2020'

-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
select c.name from collections c 
join links_collection lc on lc.collections_id = c.id 
join mus_tracks mt on mt.id = lc.mus_tracks_id
join mus_alboms ma on ma.id = mt.mus_alboms_id 
join links_alboms la on la.mus_alboms_id = ma.id 
join musicians m on m.id = la.musicians_id 
where m.name = 'Максим' 

-- название альбомов, в которых присутствуют исполнители более 1 жанра;
select ma.name, count(mg.name) from mus_alboms ma 
join links_alboms la on la.mus_alboms_id = ma.id 
join musicians m on la.musicians_id = m.id 
join links_genres lg on lg.musicians_id = m.id 
join mus_genres mg on lg.mus_genres_id = mg.id 
group by ma.name
having count(mg.name) > 1

-- наименование треков, которые не входят в сборники;
select mt.name from mus_tracks mt
full outer join links_collection lc on lc.mus_tracks_id = mt.id
left join collections c on lc.collections_id = c.id 
where c.id is null 

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select m.name, time_track from mus_tracks mt
join mus_alboms ma on ma.id = mt.mus_alboms_id
join links_alboms la on la.mus_alboms_id = ma.id 
join musicians m on m.id = la.musicians_id 
where time_track = (select min(time_track) from mus_tracks)

-- название альбомов, содержащих наименьшее количество треков.
select ma.name, count(mus_alboms_id) tracks from mus_alboms ma
join mus_tracks mt on mt.mus_alboms_id = ma.id
group by ma.name
having  count(mus_alboms_id) = (select min(mus_alboms_id) tracks from mus_alboms ma join mus_tracks mt on mt.mus_alboms_id = ma.id) --group by min(mus_alboms_id) 
order by min(mus_alboms_id)
limit 1

