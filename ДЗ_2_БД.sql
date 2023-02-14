-- список жанров
create table if not exists mus_genres (
	id serial primary key,
	name varchar(60) unique not null,
	description text not null
);

-- список исполнителей
create table if not exists musicians (
	id serial primary key,
	name varchar(60) unique not null,
	description varchar(400) not null,
    country text not null
);

-- список альбомов
create table if not exists mus_alboms (
	id serial primary key,
	name varchar(200) not null,
	description text not null,
    year varchar(4) not null
);

-- список теков
create table if not exists mus_tracks (
	id serial primary key,
	mus_alboms_id integer not null references mus_alboms(id), -- определяем внешний ключ АЛЬБОМА (один ко многим)
	name varchar(300) not null,
    time_track text not null
);

-- сборник теков
create table if not exists collections (
	id serial primary key,
	name varchar(300) not null,
    year varchar(4) not null
);

-- связывем жанры и исполнителей (многие ко многим)
create table if not exists links_genres (
    id serial primary key,
	mus_genres_id integer references mus_genres(id),
	musicians_id integer references musicians(id)
);

-- связывем альбомы и исполнителей (многие ко многим)
create table if not exists links_alboms (
    id serial primary key,
	mus_alboms_id integer references mus_alboms(id),
	musicians_id integer references musicians(id)
);

-- связывем сборники и треки (многие ко многим)
create table if not exists links_collection (
    id serial primary key,
	mus_tracks_id integer references mus_tracks(id),
	collections_id integer references collections(id)
);
