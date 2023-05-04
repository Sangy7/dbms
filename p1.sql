create table actor(
act_id number(3) primary key,
act_name varchar(50),
act_gender char
);

create table director(
dir_id number(3) primary key,
dir_name varchar(50),
dir_phone number(10)
);

create table movies(
mov_id number(3) primary key,
mov_title varchar(40),
mov_year number(4),
mov_lang varchar(10),
dir_id number(3),
foreign key (dir_id) references director(dir_id)
);

create table movie_cast(
act_id number(3),
mov_id number(3),
role varchar(15),
foreign key (act_id) references actor (act_id),
foreign key (mov_id) references movies (mov_id)
);

create table rating(
mov_id number(3),
rev_stars float,
foreign key (mov_id) references movies(mov_id)
);

insert into actor values (101, 'Kushal', 'F')
insert into actor values (102, 'Amrit', 'N')
insert into actor values (103, 'Keshav', 'M')
insert into actor values (104, 'Bibek', 'F')
select * from actor;

insert into director values (201, 'S.S. Rajamouli', 9845807018)
insert into director values (202, 'Hitchock', 9845632282)
insert into director values (203, 'Steven Spielberg', 9840305547)
insert into director values (204, 'Rhoit Shetty', 9855063147)
select * from director;

insert into movies values (301, 'Bahubali-1', 2015, 'Telugu', 201)
insert into movies values (302, 'Bahubali-2', 2017, 'Telugu', 201)
insert into movies values (303, 'GodFellas', 1994, 'English', 202)
insert into movies values (304, 'Men In Black', 2011, 'English', 203)
select * from movies;


insert into movie_cast values(101, 301, 'Hero')
insert into movie_cast values(102, 301, 'Heroine')
insert into movie_cast values(103, 303, 'Hero')
insert into movie_cast values(101, 302, 'Hero')
insert into movie_cast values(104, 304, 'Hero')
insert into movie_cast values(102, 302, 'Heroine')
select * from movie_cast;

insert into rating values (301, 4)
insert into rating values (302, 2)
insert into rating values (303, 3)
insert into rating values (304, 1)
select * from rating;

Q1) List the titles of all movies directed by ‘Hitchcock’ 

select m.mov_title
from movies m, director d
where m.dir_id = d.dir_id
and d.dir_name = 'Hitchock';

Q2) Find the movie names where one or more actors acted in two or more movies. 

select mov_title
from movies
where mov_id in (
		select mov_id
		from movie_cast
		where act_id in (
				select act_id
				from movie_cast
				group by act_id having count (act_id) > 1
				)
		);

Q3) List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation). 

select act_name, mov_title, mov_year
from actor
join movie_cast using (act_id)
join movies using (mov_id)
where mov_year not between 2000 and 2015;

Q4) Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title. 

select mov_title, max(rev_stars)
from movies
join rating using (mov_id)
group by mov_title having max(rev_stars)>1
order by mov_title;

Q5) Update rating of all movies directed by ‘Steven Spielberg’ to 5.

update rating set rev_stars = 5
where mov_id in ( select mov_id from movies where dir_id in(select dir_id from director where dir_name = 'Steven Spielberg'));